from typing import List, Dict
from flask import Flask, render_template
import mysql.connector
import json
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)

config = {
        'user': os.getenv('MYSQL_USER'),
        'password': os.getenv('MYSQL_PASSWORD'),
        'host': os.getenv('MYSQL_HOST'),
        'port': os.getenv('MYSQL_PORT'),
        'database': os.getenv('MYSQL_DATABASE'),
        'auth_plugin':'mysql_native_password'
    }
print(config)
def test_table() -> List[Dict]:
    # config = {
    #     'user': 'root',
    #     'password': 'root',
    #     'host': 'db',
    #     'port': '3306',
    #     'database': 'devopsroles'
    # }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM test_table')
    results = [{name: color} for (name, color) in cursor]
    cursor.close()
    connection.close()

    return results

@app.route('/')
def main():
    return render_template('index.html')
@app.route('/dumps')
def index() -> str:
    return json.dumps({'test_table': test_table()})


if __name__ == '__main__':
    app.run(host='0.0.0.0')
    app.run(debug=True)