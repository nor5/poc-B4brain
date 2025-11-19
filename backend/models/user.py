
from . import db
from sqlalchemy.dialects.postgresql import ARRAY

class User(db.Model):
    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True)
    # L'email est souvent utilisé comme identifiant unique
    email = db.Column(db.String(120), unique=True, nullable=False) 
    name = db.Column(db.String(120), nullable=True) # Nom complet (marie Dupont)
    
    #roles = db.Column(ARRAY(db.String))
    roles = db.Column(db.JSON)
    #relation
    environments = db.relationship("Environment", backref="user", lazy=True)

    def __repr__(self):
        return f'<User {self.name}>'