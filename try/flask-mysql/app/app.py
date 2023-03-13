from typing import List, Dict
from flask import Flask, render_template
import mysql.connector
import json

app = Flask(__name__)


def test_table() -> List[Dict]:
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'devopsroles'
    }
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