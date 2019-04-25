from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Table, Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy_imageattach.entity import Image, image_attachment

db = SQLAlchemy()

class Post(db.Model):
    __tablename__ = "posts"
    id = db.Column(db.Integer, primary_key=True)
    image = db.image_attachment("HousingPicture")
    location = db.Column(db.String, nullable=False) ''' subject to change: may be api of google maps '''
    housing_type = db.Column(db.String, nullable=False) '''subject to change'''
    price = db.Column(db.Integer, nullable=False) '''tbd'''
    contact = db.Column(db.String, nullable=False) '''this should be changed to user id'''
    postdate = db.Column(db.DateTime, default=datetime.datetime.utcnow)

    def __init__(self, **kwargs):
        self.location = kwargs.get("location", "")
        self.housing_type = kwargs.get("housing_type", "")
        self.price = kwargs.get("price", 0)
        self.contact = kwargs.get("contact", "")
        # TODO look up image library: https://sqlalchemy-imageattach.readthedocs.io/en/1.0.0/

    def serialize(self):
        return {
            "id": self.id,
            "location": self.location,
            "type": self.housing_type,
            "price": self.price,
            "contact": self.contact,
            "postdate": self.postdate.__str__(),
        }

class HousingPicture(db.Model, Image):
    """Housing picture model."""

    housing_post_id = Column(Integer, ForeignKey("posts.id"), primary_key=True)
    post = relationship("Post")
    __tablename__ = "housing_picture"

