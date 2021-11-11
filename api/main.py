from flask import Flask, request
from werkzeug import exceptions
import os
from collections import namedtuple
import jwt

app = Flask(__name__)
app.config["DEBUG"] = True

@app.errorhandler(exceptions.HTTPException)
def wrap_error(e: exceptions.HTTPException):
  return {'error': e.description}, e.code

SECRET = os.urandom(16).hex()

NOTES = {f"Note {i}": f"This is note {i}" for i in range(1, 1000)}
User = namedtuple('user', 'password notes', defaults=[NOTES])
users: dict[str, User] = {}


def get_fields(*fields):
  if not request.is_json:
    raise exceptions.BadRequest("no json data")
  try:
    return [request.json[field] for field in fields]
  except KeyError as e:
    raise exceptions.BadRequest(f"missing {e}")


@app.route('/login', methods=['POST'])
def login_route():
  username, password = get_fields('username', 'password')
  if username not in users or users[username].password != password:
    raise exceptions.Unauthorized("bad credentials")
  return {'token': jwt.encode({'iss': username}, SECRET)}


@app.route('/register', methods=['POST'])
def register_route():
  username, password = get_fields('username', 'password')
  if username in users:
    raise exceptions.Unauthorized("user already exists")
  users[username] = User(password)
  return {'token': jwt.encode({'iss': username}, SECRET)}


def get_notes():
  try:
    token = request.headers['Authentication'].split()[1]
    username = jwt.decode(token, SECRET)['iss']
    return users[username].notes
  except:
    raise exceptions.Unauthorized("invalid bearer token")


@app.route('/notes')
def notes_route():
  return {'titles': get_notes().keys()}


@app.route('/note', methods=['GET', 'PUT', 'DELETE'])
def note_route():
  notes = get_notes()
  title = get_fields('title')

  if request.method == 'GET':
    if title not in notes:
      raise exceptions.NotFound("no such note")
    return {'content': notes[title]}

  if request.method == 'PUT':
    notes[title] = get_fields('content')

  if request.method == 'DELETE':
    if title not in notes:
      raise exceptions.NotFound("no such note")
    del notes[title]


app.run()
