#! /bin/bash

apt-get update
apt-get install python3-pip python-dev -y
pip3 install Flask
cd /var
mkdir flaskapp
cd flaskapp
mkdir flaskapp
cd flaskapp
mkdir static templates

cat <<EOF > __init__.py
import socket
from flask import Flask, request, jsonify
app = Flask(__name__)

# headers
@app.route("/")
def headers():
    data_dict = dict()
    host_dict = dict()
    request_dict = dict()

    # host info
    host_dict['name'] = socket.gethostname()

    # request info
    request_dict['1) remote addr'] = request.remote_addr
    request_dict['2) remote user'] = request.remote_user
    request_dict['3) headers'] = dict(request.headers)

    # output data
    data_dict['host'] = host_dict
    data_dict['request'] = request_dict
    return data_dict

if __name__ == "__main__":
    app.run(host= '0.0.0.0', port=80, debug = True)
EOF

python3 __init__.py
