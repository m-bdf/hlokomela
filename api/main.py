from flask import Flask, request
import os

app = Flask(__name__)
app.config["DEBUG"] = True

SECRET = os.urandom(16).hex()

users = {
  "John Doe": "eod",
}

notes = {
  "Note 1": "This is note 1",
}


@app.route('/login', methods=['POST'])
def login_route():
  if not request.is_json:
    return {'error': "no json data"}, 400
  try:
    username = request.json['username']
    password = request.json['password']
  except KeyError as e:
    return {'error': f"missing {e}"}, 400
  if users.get(username) != password:
    return {'error': "bad credentials"}, 401
  return {'token': SECRET}


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
  users[username] = password
  return {'token': SECRET}


@app.route('/note', methods=['GET', 'PUT', 'DELETE'])
def note_route():
  auth = request.headers.get('Authentication')
  if not auth or auth.split()[1] != SECRET:
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
