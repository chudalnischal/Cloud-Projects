from flask import Flask, render_template, request
from pymongo import MongoClient

app = Flask(__name__)

# Connect to MongoDB server
client = MongoClient("mongodb://mongo:27017")
db = client["test_db"]  # Corrected database name here

@app.route('/')
def home():
    messages = list(db.test_collection.find({}, {"_id": 0, "Message": 1}))
    return render_template('index.html', messages=messages)
    message = request.form['message']
    db.test_collection.insert_one({"Message": message})
    return "Successfully added the message!"
    

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
