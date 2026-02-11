# importing necessary libraries and modules.
from flask import Flask,render_template,request
import pymongo 
import os
from dotenv import load_dotenv
#loading environment variables from .env file
load_dotenv()
#creating an instance of the Flask class to create our web application.
app = Flask(__name__)
#getting the MongoDB URI from environment variables and establishing a connection to the MongoDB database.
uri=os.getenv('MONGO_URI')
client =pymongo.MongoClient(uri)
database=client.My_Flask_Database
collection = database["My_Collections"]
#defining a route for the home page of the web application, which renders the 'index.html' template when accessed.
@app.route("/")
def home():
    return render_template('index.html')
#defining a route for handling form submissions from the 'index.html' page. When the form is submitted,is inserts the data into the MongoDB collection.
@app.route('/submit', methods=['POST'])
def submit():
    uname = request.form["username"]
    e_mail = request.form["email"]
    passw = request.form["password"]
    result = "Username: " + uname + " Email: " + e_mail + " Password: " + passw
    # output = dict(result=result)
    try:
        collection.insert_one({"username": uname, "email": e_mail, "password": passw})
    except Exception as e:
        return "Error Submitting data: " + str(e)
    return render_template('data_submit.html')
#running the Flask application in debug mode.
if __name__ == "__main__":
    app.run(debug=True)