from flask import Flask, jsonify # Import Flask and jsonify
from pymongo import MongoClient # type: ignore

app = Flask(__name__)
client = MongoClient('mongodb://mongo:27017/')
db = client['testdb']
collection = db['testcollection']

@app.route('/')
def home():
    return "Hello, Docker Compose with Flask and MongoDB!"

@app.route('/data')
def get_data():
    data = list(collection.find({}, {'_id': 0}))
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')