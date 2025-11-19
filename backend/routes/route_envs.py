from flask import Blueprint, current_app, jsonify, request
from flask import Flask, request, jsonify
from jose import jwt
from flask_cors import CORS
from  .route_auth import find_signing_key, decode_jwt,get_keycloak_public_keys
import requests
import subprocess

from ..models import db
from ..models.user import User
from ..models.environment import Environment
import os
from flask import abort

KEYCLOAK_REALM_URL = os.getenv('KEYCLOAK_REALM_URL') 
KEYCLOAK_CLIENT_ID = os.getenv('KEYCLOAK_CLIENT_ID')  # L'audience que nous allons vérifier
KEYCLOAK_ISSUER = os.getenv('KEYCLOAK_ISSUER')  



def launch_environment(env_type, env_name, user_id):
    if env_type == "python-VM":
        subprocess.run([
            "docker", "run", "-d",
            "--name", f"{env_name}-{user_id}",
            "python:3.11-slim",
            "sleep", "3600"
        ])
    elif env_type == "jupyter-VM":
        subprocess.run([
            "docker", "run", "-d",
            "--name", f"{env_name}-{user_id}",
            "-p", "8888:8888",
            "jupyter/base-notebook"
        ])
    return f"{env_name}-{user_id}"

env_bp = Blueprint("environments", __name__)

@env_bp.route("/environments",methods=["POST"])

def create_env():
    payload = decode_jwt(KEYCLOAK_CLIENT_ID, KEYCLOAK_ISSUER)
    user_email = payload.get('email')
    
    user_roles = payload.get("resource_access", {}).get("backend-api", {}).get("roles", [])
    if "admin" not in user_roles:
        abort(403)
    user = db.session.execute(
        db.select(User).filter_by(email=user_email)
    ).scalar_one_or_none()
    data = request.get_json()
    environment = Environment(
        name=data['name'],
        type=data['type'],
        user_id=user.id 

    )
    db.session.add(environment)
    db.session.commit()

    container_name = launch_environment(environment.type, environment.name, user.id)
    return jsonify({"name": environment.name,
        "type": environment.type,
        "status": environment.status,
        "container_name": container_name})

@env_bp.route("/environments",methods=["GET"])

def get_env():
    payload = decode_jwt(KEYCLOAK_CLIENT_ID, KEYCLOAK_ISSUER)
    user_email = payload.get('email')
    
    user = db.session.execute(
        db.select(User).filter_by(email=user_email)
    ).scalar_one_or_none()

    envs = user.environments
    #return jsonify([env.name for env in envs])
    return jsonify([{"name": env.name,"status": env.status} for env in envs])

