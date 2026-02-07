from flask import Flask, render_template,request
from dotenv import load_dotenv
import os
import pymongo

load_dotenv()

mongo_uri = os.getenv("MONGO_URI")
    # Create a new client and connect to the DB server
client = pymongo.MongoClient(mongo_uri)

app = Flask(__name__)

db= client.FLASK_DB

collection = db['Flask_Data']


@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about():
    return 'This is a simple Flask application on about page'

@app.route('/submit', methods=['POST'])
def submit():
    first_name = request.form['first_name']
    last_name = request.form['last_name']
    age = request.form['age']
    email = request.form['email']
    pwd =request.form['password']

    result = "Hi ! " + first_name + " " + last_name + ". \n Your Age is : " + age + " \n Your email is :" + email + "\n Your password is : "  + pwd + " \n\n\n  Your form has been submitted successfully."
    
    form_data = dict(request.form)
    collection.insert_one(form_data)
    return "Form submitted successfully! Thank you, " + first_name + " " + last_name + "."

@app.route('/database_view')
def data():
    data = collection.find()
    output = list(data)

    for item in output:
        del item['_id']
    return {"data": output}


if __name__ == '__main__':
    app.run(debug=True)