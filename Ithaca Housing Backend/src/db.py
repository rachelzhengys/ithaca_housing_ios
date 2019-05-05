import datetime
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Table, Column, Integer, ForeignKey, DateTime, desc, MetaData
from sqlalchemy.orm import relationship, mapper

db = SQLAlchemy()

mymetadata = MetaData()

columns = (
    db.Column("houseurl", db.String, primary_key=True),
    db.Column("imageurl", db.String, nullable=True),
    db.Column("location", db.String, nullable=False),
    # subject to change: may be api of google maps
    db.Column("type", db.String, nullable=False),  # subject to change
    db.Column("price", db.Integer, nullable=False),  # tbd
    db.Column("description", db.String, nullable=False),
    # contact = db.Column(db.String, nullable=False)
    # this should be changed to user id
    db.Column("postdate", db.String, nullable=False),
)

jsontable = Table("house_in_json", mymetadata, *columns)


class Housing(object):
    def __init__(self, json_data):
        json_data = open("house.json")
        data = json.load(json_data)
        for key, value in data.iteritems():
            setattr(self, key, value)

    def serialize(self):
        return {
            # "id": self.id,
            "location": self.location,
            "type": self.housing_type,
            "price": self.price,
            # "contact": self.contact,
            "postdate": self.postdate,
            "imageurl": self.imageurl,
            "description": self.description,
            "houseurl": self.houseurl,
        }


mapper(Housing, jsontable)


class House(db.Model):
    __tablename__ = "houses"
    id = db.Column(db.Integer, primary_key=True)
    houseurl = db.Column(db.String, nullable=False)
    imageurl = db.Column(db.String, nullable=True)
    location = db.Column(db.String, nullable=False)
    # subject to change: may be api of google maps
    housing_type = db.Column(db.String, nullable=False)  # subject to change
    price = db.Column(db.Integer, nullable=False)  # tbd
    description = db.Column(db.String, nullable=False)
    # contact = db.Column(db.String, nullable=False)
    # this should be changed to user id
    postdate = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.imageurl = kwargs.get("imageurl", "")
        self.houseurl = kwargs.get("houseurl", "")
        self.location = kwargs.get("location", "")
        self.description = kwargs.get("description", "")
        self.housing_type = kwargs.get("housing_type", "")
        self.price = kwargs.get("price", 0)
        # self.contact = kwargs.get("contact", "")
        self.postdate = kwargs.get("postdate", "")

        # TODO look up image library: https://sqlalchemy-imageattach.readthedocs.io/en/1.0.0/

    def serialize(self):
        return {
            # "id": self.id,
            "location": self.location,
            "type": self.housing_type,
            "price": self.price,
            # "contact": self.contact,
            "postdate": self.postdate,
            "imageurl": self.imageurl,
            "description": self.description,
            "houseurl": self.houseurl,
        }
