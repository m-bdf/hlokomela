# Hlokomela

A cross-platform multi-user note-taking application

## Server

The server is built with Python 3 using Flask

To start it, simply run `./runapi.sh`

This script will automagically:
- Create and activate a new Python virtual environment
- Install all needed dependencies in the isolated venv
- Run the server and make it listen on `localhost:5000`

## Client

Shake your device to setup the address of the server in the app

`localhost` won't work, you'll have to type in your computer IP
