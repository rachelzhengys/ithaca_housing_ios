import json
from flask import Flask, request
from db import db, Post, HousingPicture

app = Flask(__name__)

db_filename = "posts.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route("/")
@app.route("/api/posts/")
def get_posts():
    posts = Class.query.all()
    res = {"success": True, "data": [post.serialize() for post in posts]}
    return json.dumps(res), 200


@app.route("/api/classes/", methods=["POST"])
def post_posts():
    post_body = json.loads(request.data)
    post = Post(
        # TODO image
        location=post_body.get("location"),
        housing_type=post_body.get("type"),
        contact=post_body.get("contact"),
        price=post_body.get("price"),
    )
    db.session.add(post)
    db.session.commit()
    return json.dumps({"success": True, "data": post.serialize()}), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

