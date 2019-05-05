import json
import os
from flask import Flask, request, url_for
from db import db, House, Housing
from sqlalchemy import desc
from datetime import datetime, timedelta

app = Flask(__name__)

db_filename = "houses.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route("/api/houses")
def get_houses():
    sort_options = request.args.get("sort_options", default="0")
    if sort_options == "0":
        houses = House.query.all()
    # elif sort_options == 1:
    #     houses = House.query.order_by(House.postdate).all()
    elif sort_options == "2":
        houses = House.query.order_by(House.price).all()
    elif sort_options == "3":
        houses = House.query.order_by(desc(House.price)).all()
    else:
        res = {"data": "invalid_sort_options"}
        return json.dumps(res), 404
    res = {"data": [house.serialize() for house in houses]}
    return json.dumps(res), 200


@app.route("/api/house/<int:house_id>/")
def get_house_by_id(house_id):
    house = House.query.filter_by(id=house_id).first()
    if house is None:
        return json.dumps({"error": "House not found!"}), 404
    res = {"data": house.serialize()}
    return json.dumps(res)


def refresh_json():
    os.system('bash -c "python3 web_scraper.py"')


# whether the house with specific description already exists in the db
def exists(descpt):
    house = House.query.filter_by(description=descpt).first()
    if house is None:
        return False
    else:
        return True


@app.route("/api/house/", methods=["POST"])
def post_house():
    refresh_json()
    data = open("house.json")
    post_bodies = json.load(data)
    house = []
    for post_body in post_bodies:
        if not exists(post_body.get("description")):
            house.append(House(
            imageurl=post_body.get("imageUrl"),
            location=post_body.get("location"),
            housing_type=post_body.get("type"),
            # contact=post_body.get("contact"),
            price=post_body.get("price"),
            postdate=post_body.get("postdate"),
            houseurl=post_body.get("url"),
            description=post_body.get("description"),
        ))
    # TODO delete all previous info
    db.session.bulk_save_objects(house)
    db.session.commit()
    return json.dumps({"data": post_bodies}), 201


@app.route("/api/house/<int:house_id>/", methods=["DELETE"])
def delete_house_by_id(house_id):
    house = House.query.filter_by(id=house_id).first()

    if house is not None:
        db.session.delete(house)
        db.session.commit()
        return json.dumps({""""success": True,""" "data": house.serialize()}), 200

    return json.dumps({""""success": False,""" "error": "House not found!"}), 404


# add all house information in house_dicts to db
def add_houses(house_dicts):
    house = [
        House(
            imageurl=house_dict["imageUrl"],
            location=house_dict["location"],
            housing_type=house_dict["type"],
            price=house_dict["price"],
            postdate=house_dict["postdate"],
            houseurl=house_dict["url"],
            description=house_dict["description"],
        )
        for house_dict in house_dicts
    ]

    db.session.bulk_save_objects(house)
    db.session.commit()


# def work_refresh():
#     with app.app_context():
#         while 1:
#             post_house()

#             dt = datetime.now() + timedelta(hours=4)
#             dt = dt.replace(hour=1)

#             while datetime.now() < dt:
#                 time.sleep(1)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
    # work_refresh()
