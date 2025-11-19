from flask import Blueprint, current_app, jsonify, request
from flask import Flask, request, jsonify
from jose import jwt
from dotenv import load_dotenv
import requests
from flask_cors import CORS
from ..models import db
from ..models.user import User
from ..models.environment import Environment
import os


auth_bp = Blueprint('auth', __name__)
load_dotenv() 

# Configuration Keycloak
KEYCLOAK_REALM_URL = os.getenv('KEYCLOAK_REALM_URL') 
KEYCLOAK_CLIENT_ID = os.getenv('KEYCLOAK_CLIENT_ID')  # L'audience que nous allons vérifier
KEYCLOAK_ISSUER = os.getenv('KEYCLOAK_ISSUER')  # L'émetteur que nous allons vérifier

# Cache simple pour les clés (évite de les redemander à chaque requête)
# Dans une vraie app, utilisez un cache plus robuste (ex: Flask-Caching)
_jwks_keys = None

def get_keycloak_public_keys():
    """
    Récupère les clés publiques (JWKS) de Keycloak.
    Met en cache le résultat pour de meilleures performances.
    """
    global _jwks_keys
    if _jwks_keys:
        return _jwks_keys

    try:
        resp = requests.get(f"{KEYCLOAK_REALM_URL}/protocol/openid-connect/certs")
        resp.raise_for_status() # Lève une erreur si la requête échoue
        jwks = resp.json()
        _jwks_keys = jwks["keys"]
        return _jwks_keys
    except requests.exceptions.RequestException as e:
        current_app.logger.error(f"Impossible de récupérer les clés JWKS: {e}")
        return None

def find_signing_key(token):
    """
    Trouve la bonne clé publique dans le JWKS en se basant 
    sur le 'kid' (Key ID) de l'en-tête du token.
    """
    try:
        # 1. Obtenir l'en-tête du token SANS le valider (juste pour lire le kid)
        unverified_header = jwt.get_unverified_header(token)
    except Exception as e:
        raise ValueError(f"En-tête de token invalide: {e}")
        
    kid = unverified_header.get("kid")
    if not kid:
        raise ValueError("En-tête 'kid' manquant dans le token")

    # 2. Récupérer toutes les clés publiques de Keycloak
    public_keys = get_keycloak_public_keys()
    if not public_keys:
        raise ValueError("Impossible de récupérer les clés publiques du serveur d'identité")

    # 3. Trouver la clé correspondante
    for key in public_keys:
        if key["kid"] == kid:
            return key # Retourne la clé publique (format JWK)

    raise ValueError(f"Clé publique (kid: {kid}) non trouvée")


def decode_jwt( audience, issuer):
    auth_header = request.headers.get("Authorization", "")
    token = auth_header.replace("Bearer ", "")
    if not token:
        return jsonify({"error": "Missing token"}), 401

    try:
        
        
        # 1. Trouver la clé de signature
        signing_key = find_signing_key(token)

        # 2. Décoder ET VÉRIFIER le token
        # Ceci vérifie :
        # - La signature (avec la bonne clé)
        # - L'expiration (exp)
        # - L'audience (aud)
        # - L'émetteur (iss)
        payload = jwt.decode(
            token,
            signing_key,
            algorithms=["RS256"],
            audience=audience, # Doit être destiné à notre API
            issuer=issuer      # Doit venir du bon realm Keycloak
        )
        return payload
        # --- Gestion fine des erreurs de validation ---
    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.JWTClaimsError as e:
        # Erreur si l'audience (aud) ou l'émetteur (iss) ne correspond pas
        return jsonify({"error": "Invalid claims", "details": str(e)}), 401
    except ValueError as e:
        # Nos propres erreurs (ex: clé non trouvée)
        return jsonify({"error": str(e)}), 401
    except jwt.JWTError as e:
        # Toute autre erreur JWT (ex: signature invalide)
        return jsonify({"error": "Invalid token", "details": str(e)}), 401
    except Exception as e:
        current_app.logger.error(f"Erreur interne: {e}")
        return jsonify({"error": "An internal error occurred"}), 500

@auth_bp.route('/auth', methods=['GET'])
def get_auth():
    payload = decode_jwt(KEYCLOAK_CLIENT_ID, KEYCLOAK_ISSUER)
    user_email = payload.get('email')
    user_name = payload.get('name')
    user_roles = payload.get("resource_access", {}).get("backend-api", {}).get("roles", [])
     
    user = db.session.execute(
        db.select(User).filter_by(email=user_email)
    ).scalar_one_or_none()

    if user:
        
        current_app.logger.info(f"Utilisateur existant trouvé: {user_name}. Mise à jour du login.")
    else:
        new_user = User(
            email=user_email,
            name=user_name,
            roles=user_roles,
            
        )
        db.session.add(new_user)
        current_app.logger.info(f"Nouvel utilisateur créé: {user_name}.")
    
    db.session.commit()
       
        
        
    return jsonify(payload)
