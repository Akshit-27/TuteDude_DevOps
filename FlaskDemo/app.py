from flask import Flask, render_template,request
app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about():
    return 'This is a simple Flask application on about page'

@app.route('/api/<age>')
def checkAge(age):
        if int(age) < 18:
            return 'You are a minor.'
        else:
            return 'You are an adult.'



if __name__ == '__main__':
    app.run(debug=True)