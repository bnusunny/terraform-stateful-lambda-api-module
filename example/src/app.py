import os
from datetime import datetime

import awsgi
from flask import (Flask, jsonify)

app = Flask(__name__)


@app.route('/hello', methods=['GET'])
def get_records():
    with open("/mnt/shared/test.txt", 'rb') as f:
        content = tail(f, 10)
    return str(content, encoding='utf-8')


@app.route('/hello', methods=['POST'])
def append_record():
    with open("/mnt/shared/test.txt", 'a', encoding='utf-8') as f:
        f.write("{}: hello from lambda instance {}\n".format(datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S%z"),
                                                             os.uname()[1]))
    return 'data added'


def tail(f, lines=20):
    total_lines_wanted = lines

    block_size = 1024
    f.seek(0, 2)
    block_end_byte = f.tell()
    lines_to_go = total_lines_wanted
    block_number = -1
    blocks = []
    while lines_to_go > 0 and block_end_byte > 0:
        if block_end_byte - block_size > 0:
            f.seek(block_number * block_size, 2)
            blocks.append(f.read(block_size))
        else:
            f.seek(0, 0)
            blocks.append(f.read(block_end_byte))
        lines_found = blocks[-1].count(b'\n')
        lines_to_go -= lines_found
        block_end_byte -= block_size
        block_number -= 1
    all_read_text = b''.join(reversed(blocks))
    return b'\n'.join(all_read_text.splitlines()[-total_lines_wanted:])


def lambda_handler(event, context):
    return awsgi.response(app, event, context, base64_content_types={"image/png"})
