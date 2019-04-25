import json
from flask import Flask, request
from db import db, House, HousingPicture

app = Flask(__name__)

db_filename = "houses.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route("/api/houses/")
def get_houses():
    houses = House.query.all()
    res = {"success": True, "data": [house.serialize() for house in houses]}
    return json.dumps(res), 200


@app.route("/api/house/<int:house_id>/")
def get_house_by_id(house_id):
    house = House.query.filter_by(id=house_id).first()
    if house is None:
        return json.dumps({'success': False, 'error': 'House not found!'}), 404

    res = {"success": True, "data": house.serialize()}
    return json.dumps(res)


@app.route("/api/house/", methods=["POST"])
def post_house():
    post_body = json.loads(request.data)
    house = House(
        # TODO image
        location=post_body.get("location"),
        housing_type=post_body.get("type"),
        contact=post_body.get("contact"),
        price=post_body.get("price"),
    )
    db.session.add(house)
    db.session.commit()
    return json.dumps({"success": True, "data": house.serialize()}), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
