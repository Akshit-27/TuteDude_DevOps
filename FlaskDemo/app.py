from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'Welcome to the Flask Demo!'

@app.route('/about')
def about():
    return 'This is a simple Flask application.'

@app.route('/api/<age>')
def checkAge(age):
        if int(age) < 18:
            return 'You are a minor.'
        else:
            return 'You are an adult.'



if __name__ == '__main__':
    app.run(debug=True)