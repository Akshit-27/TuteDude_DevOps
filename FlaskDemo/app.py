from flask import Flask, render_template,request
app = Flask(__name__)

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
    return form_data


if __name__ == '__main__':
    app.run(debug=True)