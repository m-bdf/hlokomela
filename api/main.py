from flask import Flask, request

app = Flask(__name__)
app.config["DEBUG"] = True

users = {
  "John Doe": "eod",
}

notes = {
  "Note 1": "This is note 1",
}


@app.route('/login', methods=['POST'])
def login_route():
  if not request.is_json:
    return "no json data", 400
  try:
    username = request.json['username']
    password = request.json['password']
  except KeyError as e:
    return f"missing {e}", 400
  if users.get(username) != password:
    return "bad credentials", 401


@app.route('/register', methods=['POST'])
def register_route():
  if not request.is_json:
    return "no json data", 400
  try:
    username = request.json['username']
    password = request.json['password']
  except KeyError as e:
    return f"missing {e}", 400
  if username in users:
    return "user already exists", 401
  users[username] = password


@app.route('/note', methods=['GET', 'PUT', 'DELETE'])
def note_route():
  if request.method == 'GET':
    return notes

  if request.method == 'PUT':
    if not request.is_json:
      return "no json data", 400
    try:
      title = request.json['title']
      content = request.json['content']
    except KeyError as e:
      return f"missing {e}", 400
    notes[title] = content

  if request.method == 'DELETE':
    if not request.is_json:
      return "no json data", 400
    try:
      title = request.json['title']
    except KeyError as e:
      return f"missing {e}", 400
    if title not in notes:
      return "no such note", 404
    del notes[title]


app.run()
