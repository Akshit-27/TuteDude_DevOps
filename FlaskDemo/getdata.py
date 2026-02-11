from flask import Flask, render_template
import pymongo
from dotenv import load_dotenv
import os

load_dotenv()
uri = os.getenv('MONGO_URI')
client = pymongo.MongoClient(uri)
db = client.My_Flask_Database
collection = db.My_Collections

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('getdata.html')

@app.route("/api", methods=['POST'])
def getdata():
    data = collection.find()
    output = []
    for item in data:
        output.append({"username": item["username"], "email": item["email"], "password": item["password"]})
    return {"data": output}

if __name__ == "__main__":
    app.run(debug=True)
