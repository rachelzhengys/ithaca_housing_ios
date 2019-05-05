import json
from flask import Flask, request, url_for
from db import db, House, Housing
from sqlalchemy import desc

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
        res = {"success": False, "data": "invalid_sort_options"}
        return json.dumps(res), 404
    res = {"success": True, "data": [house.serialize() for house in houses]}
    return json.dumps(res), 200


@app.route("/api/house/<int:house_id>/")
def get_house_by_id(house_id):
    house = House.query.filter_by(id=house_id).first()
    if house is None:
        return json.dumps({"success": False, "error": "House not found!"}), 404
    res = {"success": True, "data": house.serialize()}
    return json.dumps(res)


@app.route("/api/house/", methods=["POST"])
def post_house():
    data = open("house.json")
    post_bodies = json.load(data)
    house = [
        House(
            imageurl=post_body.get("imageUrl"),
            location=post_body.get("location"),
            housing_type=post_body.get("type"),
            # contact=post_body.get("contact"),
            price=post_body.get("price"),
            postdate=post_body.get("postdate"),
            houseurl=post_body.get("url"),
            description=post_body.get("description"),
        )
        for post_body in post_bodies
    ]
    db.session.query(House).delete()
    db.session.bulk_save_objects(house)
    db.session.commit()
    return json.dumps({"success": True, "data": post_bodies}), 201


@app.route("/api/house/<int:house_id>/", methods=["DELETE"])
def delete_house_by_id(house_id):
    house = House.query.filter_by(id=house_id).first()

    if house is not None:
        db.session.delete(house)
        db.session.commit()
        return json.dumps({"success": True, "data": house.serialize()}), 200

    return json.dumps({"success": False, "error": "House not found!"}), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
