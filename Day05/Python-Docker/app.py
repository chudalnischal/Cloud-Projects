from flask import Flask  # type: ignore


app = Flask(__name__)

@app.route('/')
def test():
    return "Hello, World!"

if __name__ == "__main__":
    app.run(debug=True, port=80, host="0.0.0.0")

    