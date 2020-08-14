import os
from datetime import datetime

import awsgi
from flask import (Flask, request)

app = Flask(__name__)

MOUNT_PATH = os.environ.get('LOCAL_MOUNT_PATH') or '.'
DATA_FILE = MOUNT_PATH + '/msg.txt'


@app.route('/msg', methods=['GET'])
def get_records():
    if os.path.exists(DATA_FILE):
        with open(DATA_FILE, 'rb') as f:
            content = f.read()
    else:
        content = "no messages"
    return content


@app.route('/msg', methods=['POST'])
def append_record():
    req_data = request.get_json()
    with open(DATA_FILE, 'a', encoding='utf-8') as f:
        f.write("{}: {}\n".format(datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S%z"),
                                  req_data["msg"]))
    return 'message added'


@app.route('/msg', methods=['DELETE'])
def delete_file():
    if os.path.exists(DATA_FILE):
        os.remove(DATA_FILE)
    return 'messages deleted'


def lambda_handler(event, context):
    return awsgi.response(app, event, context, base64_content_types={"image/png"})
