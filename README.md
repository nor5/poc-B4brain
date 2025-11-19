
# B4Brain POC – Résumé
## Objectif de la POC

L’objectif principal de cette POC est de valider l’intégration d’une authentification centralisée basée sur Keycloak, reliée à un annuaire LDAP, et de tester la création d’environnements scientifiques via une API REST.
Plus précisément, il s’agissait de démontrer :

1. Déploiement d'un annuaire OpenLDAP (avec utilisateurs de test)

2. L’intégration Keycloak ↔ OpenLDAP (synchronisation des utilisateurs).

3. La sécurisation d’un frontend et d’un backend via OAuth2 / OpenID Connect.

4. La validation des tokens JWT côté backend.

5. La mise en place d’API REST capables de créer dynamiquement des environnements scientifiques (par exemple des conteneurs Python/Jupyter).

6. La gestion des accès en fonction des rôles Keycloak (les admins peuvent créer des environnements, les utilisateurs peuvent seulement les consulter).

## Architecture et fonctionnement
L'environnement est entièrement orchestré via `docker compose`

1.  **Authentification et rôles**

- OpenLDAP fournit des utilisateurs de test.

- Keycloak est configuré pour mapper les utilisateurs LDAP et gérer les rôles.

- Deux clients Keycloak sont configurés : un pour le frontend et un pour le backend (clientscoop) avec mapping de l’audience pour valider les JWT.

- Le frontend redirige vers Keycloak pour l’authentification et récupère un token JWT.

- Le backend Flask valide ce token et récupère les informations de l’utilisateur (nom, email, rôles).

2. **Gestion des environnements scientifiques**

- Les utilisateurs peuvent consulter leurs environnements scientifiques existants.

- Les utilisateurs avec le rôle admin peuvent créer de nouveaux environnements.

- La création d’un environnement lance un conteneur Docker sur la machine hôte :  python-VM → conteneur Python, jupyter-VM → conteneur Jupyter Notebook 

3. **Frontend**

- Affiche le profil utilisateur (nom, email, rôles).

- Affiche la liste des environnements scientifiques de l’utilisateur.

- Permet aux admins de créer de nouveaux environnements via un formulaire.

4. **Backend**

- Gère les routes API :

- /api/auth → validation du token JWT et récupération des informations utilisateur

- /api/environments → création et récupération des environnements scientifiques

- Communique avec Docker pour lancer les conteneurs sur la machine hôte depuis le conteneur Flask.

## Reproduction de la POC
### Prérequis
- Docker et Docker Compose installés sur la machine.
- Cloner le dépôt contenant le frontend, le backend et les fichiers de configuration.

### Lancer la stack

1. **Démarrer tous les conteneurs** 
`docker compose up --build -d`
2. **Initialiser LDAP**
`docker exec -it openldap ldapadd -x -D "cn=admin,dc=neurospin,dc=com" -w admin_pass -f /tmp/init.ldif`
3. **Importer la configuration Keycloak**
`cat keycloak_dump.sql | docker exec -i postgres_db psql -U keycloak_db_user -d keycloak_db`
4. **Assigner des rôles aux utilisateurs dans Keycloak**
 - Accéder à l’interface Keycloak : http://localhost:8080
 - Sélectionner le realm : *testpoc*
 - Aller dans Users, afficher les trois utilisateurs avec * sur la recherche 
 - Selectionner un utilisateur et dans la section  *Roles mapping* cliquer sur *Assign role* et filtrer par client .
 - Sélectionner le rôle souhaité (*backend-api admin* ou *backend-api user*) puis cliquer sur *Assign*.


5. **Initialiser la base Flask**
```
docker exec -it flask_backend bash 
flask db init
flask db migrate
flask db upgrade
```
### Accéder à la POC

Frontend : http://localhost:5173

Keycloak : http://localhost:8080

PHP LDAP Admin : http://localhost:80

## Suggestions d'Amélioration pour la PoC

1. **Limitation des Ressources**: Implémenter des limites de CPU et de RAM lors de la création du conteneur (via l'API Docker) pour éviter qu'un seul environnement scientifique ne monopolise les ressources de l'hôte.
2. **Dashboard monitoring**: pour collecter des métriques sur l'utilisation des conteneurs créés (CPU, mémoire,).
3. **Arrêt des conteneurs**: Mettre en place une route pour arrêter les environement, et pour arrêter automatiquement les conteneurs inactifs.
4. **Persistance et Volumes**: sauvegarde des données des volumes pour les projets des utilisateurs.
5. **Partage d'Environnement**: Implémenter la logique côté Flask et Keycloak pour qu'un utilisateur puisse inviter un autre utilisateur.


