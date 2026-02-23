from flask import Flask,request,render_template
import requests
import pymongo
import os
from dotenv import load_dotenv

load_dotenv()

MONGO_URI=os.getenv('MONGO_URI')

client = pymongo.MongoClient(MONGO_URI)
database = client.ToDoList_DB
collections = database['ToDOItems']

app = Flask(__name__)

@app.route('/submit', methods=['POST'])
def submit():

    # todo_item=dict(request.json)
    todo_item=request.json['todo']
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
    app.run(debug=True,host='0.0.0.0',port=8000)