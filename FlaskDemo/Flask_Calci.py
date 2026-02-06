from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return 'Welcome to the Calculator Demo on home page!'

@app.route('/add/<int:num1>/<int:num2>')
def add(num1, num2):
    return f'The sum of {num1} and {num2} is {num1 + num2}'

@app.route('/sub/<int:num1>/<int:num2>')
def sub(num1, num2):
    return f'The Diff of {num1} and {num2} is {num1 - num2}'

@app.route('/mul/<int:num1>/<int:num2>')
def mul(num1, num2):
    return f'The product of {num1} and {num2} is {num1 * num2}'

@app.route('/div/<int:num1>/<int:num2>')
def div(num1, num2):
    return f'The Division of {num1} and {num2} is {num1 / num2}'

@app.route('/mod/<int:num1>/<int:num2>')
def mod(num1, num2):
    return f'The reminder of {num1} divided by {num2} is {num1 % num2}'

if __name__ =="__main__" :
    app.run(debug=True)
