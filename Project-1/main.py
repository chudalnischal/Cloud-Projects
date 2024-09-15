# Importing the Flask module
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def landing_page():
    # Correct the path for the template
    return render_template('index.html')

@app.route('/home')
def home():
    return render_template('home.html')


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=80)
