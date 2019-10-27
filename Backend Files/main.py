import firebase_admin
from firebase_admin import db
import flask

app = flask.Flask(__name__)

firebase_admin.initialize_app(options={
    'databaseURL': 'https://arugula-fire.firebaseio.com'
})

user_details = db.reference('user_details')

@app.route('/usermatches', methods=['POST'])
def create_user():
    req = flask.request.json
    user = user_details.push(req)
    return flask.jsonify({'id': user.key}), 201

@app.route('/usermatches/<id>')
def read_user(id):
    return flask.jsonify(_ensure_user(id))

@app.route('/usermatches/<id>', methods=['PUT'])
def update_user(id):
    _ensure_user(id)
    req = flask.request.json
    user_details.child(id).update(req)
    return flask.jsonify({'success': True})

@app.route('/usermatches/<id>', methods=['DELETE'])
def delete_user(id):
    _ensure_user(id)
    user_details.child(id).delete()
    return flask.jsonify({'success': True})

def _ensure_user(id):
    user = user_details.child(id).get()
    if not user:
        flask.abort(404)
    return user

def tindering(id):
    user = _ensure_user(id)
    poss_matches = user_details.order_by_child('language').limit_to_first(100).get()
    for key, val in poss_matches.items():
        if val['language'] == user['language'] and val['uid'] != user['uid']:
            print(_ensure_user(key)['name'])

tindering("-LsAqKR3am4Qwssqdox4")

'''
from flask import Flask, jsonify, request

app = Flask(__name__)
user_info = {"id": 00000000,
             "name": "Abraham Lincoln",
             "language": "Italian",
             "proficiency": "Beginner",
             "location": "Springfield, Illinois"}


@app.route('/home', methods = ['GET'])
def initialize_user():
    user_data = user_info
    return jsonify(user_data)

@app.route('/update', methods = ['GET','POST'])
def update_user():
    user_data = user_info
    inp_name = request.args.get("name") or user_data["name"]
    inp_lang = request.args.get("language") or user_data["language"]
    inp_prof = request.args.get("proficiency") or user_data["proficiency"]
    inp_loc = request.args.get("location") or user_data["location"]
    user_data = {"id": user_info["id"],
                 "name": inp_name,
                 "language": inp_lang,
                 "proficiency": inp_prof,
                 "location": inp_loc}
    for key in user_data:
        user_info[key] = user_data[key]
    return jsonify(user_data)
    # format: localhost:5000/add?item=Walnuts


if __name__ == "__main__":
    app.run()
        # app.run(debug=True)
'''
