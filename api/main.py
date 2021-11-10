import flask
from flask import request, jsonify

app = flask.Flask(__name__)
app.config["DEBUG"] = True

# Create some test data for our catalog in the form of a list of dictionaries.
users = [
    {'username': 'John Doe', 'password': 'eod'},
]

notes = [];

@app.route('/', methods=['GET'])
def home():
    return 'it is what it is'


# A route to return all of the available entries in our catalog.
@app.route('/users', methods=['GET'])
def api_all():
    return jsonify(users)

@app.route('/login', methods=['POST'])
def check_if_login():
  if request.json:
    results = []
    json = request.json
    if 'username' in request.json and 'password' in request.json :
      username = json['username']
      password = json['password']
    else:
      return results
    for user in users:
      if user['username'] == username and user['password'] == password :
          results.append(user)
    return jsonify(results)
  else:
    return jsonify({"error": "no json data"})
  

@app.route('/register', methods=['POST'])
def store_it():
  if request.json:
    results = []
    json = request.json
    if 'username' in json and 'password' in json :
      username = json['username']
      password = json['password']
    else:
      return results
    for user in users:
      if user['username'] == username :
        return jsonify({"error": "username already exists"})
    users.append({'username': username, 'password': password})
    return jsonify(users)
  else:
    return jsonify({"error": "no json data"})


@app.route('/note', methods=['GET', 'POST', 'DELETE'])
def note():
  if request.method == 'GET':
    return jsonify(notes);
  if request.method == 'POST':
    if request.json:
      json = request.json
      if 'title' in json and 'content' in json :
        title = json['title']
        content = json['content']
      else:
        return jsonify({"error": "no json data"})
      notes.append({'title': title, 'content': content})
      return jsonify(notes)
    else:
      return jsonify({"error": "no json data"})
  if request.method == 'DELETE':
    if request.json:
      json = request.json
      if 'title' in json :
        title = json['title']
      else:
        return jsonify({"error": "no json data"})
      notes.pop(title)
      return jsonify(notes)
    else:
      return jsonify({"error": "no json data"})


app.run()