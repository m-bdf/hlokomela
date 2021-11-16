#/bin/sh

python3 -m venv env
source env/bin/activate
python3 -m pip install -r api/requirements.txt
python3 api/main.py
