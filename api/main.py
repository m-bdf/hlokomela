from flask import Flask, request

app = Flask(__name__)
app.config["DEBUG"] = True

users = {
  'John Doe': 'eod',
}

notes = {
  'Note 1': 'This is note 1',
}

@app.route('/', methods=['GET'])
def home():
    return 'it is what it is'

@app.route('/users', methods=['GET'])
def api_all():
    return users

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
    if users[username] == password :
      results.append(users[username])
    return results, 400
  else:
    return {"error": "no json data"}, 400
  

@app.route('/register', methods=['POST'])
def store_it():
  if request.json:
    results = []
    json = request.json
    if 'username' in json and 'password' in json :
      username = json['username']
      password = json['password']
    else:
      return results, 401
    if username in users :
      return {"error": "username already exists"}
    users[username] = password
    return users
  else:
    return {"error": "no json data"}, 400


@app.route('/note', methods=['GET', 'PUT', 'DELETE'])
def note():
  if request.method == 'GET':
    return notes;
  if request.method == 'PUT':
    if request.json:
      json = request.json
      if 'title' in json and 'content' in json :
        title = json['title']
        content = json['content']
      else:
        return {"error": "no json data"}, 400
      notes[title] = content
      return notes
    else:
      return {"error": "no json data"}, 400
  if request.method == 'DELETE':
    if request.json:
      json = request.json
      if 'title' in json :
        title = json['title']
      else:
        return {"error": "no json data"}, 400
      try:  
        notes.pop(title)
      except:
        return {"error": "no such note"}, 404
      return notes
    else:
      return {"error": "no json data"}, 400


app.run()
