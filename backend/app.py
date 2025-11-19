from flask import Flask 
from dotenv import load_dotenv
from .models import db, migrate
from .routes.route_auth import auth_bp
from .routes.route_envs import env_bp
from flask_cors import CORS
import os

load_dotenv()

def create_app():
   

    app = Flask(__name__)
    CORS(app, supports_credentials=True, origins=["http://localhost:5173"]) 
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
      # Initialisation des extensions
    db.init_app(app)
    migrate.init_app(app, db)

    app.register_blueprint(auth_bp, url_prefix='/api')
    app.register_blueprint(env_bp, url_prefix='/api')

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)