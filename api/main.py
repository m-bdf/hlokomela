from flask import Flask, request
import os
from collections import namedtuple
import jwt

app = Flask(__name__)
app.config["DEBUG"] = True

SECRET = os.urandom(16).hex()

NOTES = {f"Note {i}": f"This is note {i}" for i in range(1, 1000)}
User = namedtuple('user', 'password notes', defaults=[NOTES])
users: dict[str, User] = {}


@app.route('/login', methods=['POST'])
def login_route():
  if not request.is_json:
    return {'error': "no json data"}, 400
  try:
    username = request.json['username']
    password = request.json['password']
  except KeyError as e:
    return {'error': f"missing {e}"}, 400
  if username not in users or users[username].password != password:
    return {'error': "bad credentials"}, 401
  return {'token': jwt.encode({'iss': username}, SECRET)}


@app.route('/register', methods=['POST'])
def register_route():
  if not request.is_json:
    return {'error': "no json data"}, 400
  try:
    username = request.json['username']
    password = request.json['password']
  except KeyError as e:
    return {'error': f"missing {e}"}, 400
  if username in users:
    return {'error': "user already exists"}, 401
  users[username] = User(password)
  return {'token': jwt.encode({'iss': username}, SECRET)}


@app.route('/note', methods=['GET', 'PUT', 'DELETE'])
def note_route():
  try:
    token = request.headers['Authentication'].split()[1]
    username = jwt.decode(token, SECRET)['iss']
    notes = users[username].notes
  except:
    return {'error': "invalid bearer token"}, 401

  if request.method == 'GET':
    return {'notes': notes}

  if request.method == 'PUT':
    if not request.is_json:
      return {'error': "no json data"}, 400
    try:
      title = request.json['title']
      content = request.json['content']
    except KeyError as e:
      return {'error': f"missing {e}"}, 400
    notes[title] = content

  if request.method == 'DELETE':
    if not request.is_json:
      return {'error': "no json data"}, 400
    try:
      title = request.json['title']
    except KeyError as e:
      return {'error': f"missing {e}"}, 400
    if title not in notes:
      return {'error': "no such note"}, 404
    del notes[title]


app.run()
