from flask import Flask,render_template ,request
import requests
import pymongo
import os
from dotenv import load_dotenv

load_dotenv()
app = Flask(__name__)

BACKEND_URL= os.getenv('BACKEND_URL')

MONGO_URI=os.getenv('MONGO_URI')

client = pymongo.MongoClient(MONGO_URI)
database = client.ToDo_DB
collections = database["ToDOItems"]

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/submit', methods=['POST'])
def submit():
    todo_item=request.form['todo']
    # todo_item=dict(request.form)
    collections.insert_one({"todo": todo_item})

    return render_template('submit.html')

@app.route('/view')
def view():
    items = collections.find()
    items = list(items)
    for item in items:
        print(item)
        del item['_id'] 
    data = {"items": items}
    return data

if __name__ == '__main__':
    app.run(debug=True)