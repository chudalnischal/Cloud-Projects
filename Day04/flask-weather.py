from flask import Flask, request
from flask import jsonify
import requests


app = Flask("__name__")

@app.route('/')
def weather():
    api_key = "e839c87aff54e34a60804e78bcc26fc6"
    BASE_URL = "http://api.openweathermap.org/data/2.5/weather"

    user_city = request.args.get("city")
    if not user_city:
        return jsonify({"error": "City name is required"}), 400

    # parameters for api
    param = { 'q': user_city, 'appid': api_key, 'units': 'metric' }
    try:
        response = requests.get(BASE_URL, params=param)
        data = response.json()

        if response.status_code != 200:
            return jsonify({"error": data.get("message", "Something went wrong")}), response.status_code


        weather_data = {
                "city" : data["name"],
            "temp" : data["main"]["temp"],
            "weather_description" : data["weather"][0]["description"],
            "humidity" : data["main"]["humidity"],
            "wind_speed" : data["wind"]["speed"],
            }
        return jsonify(weather_data)

    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(port=5000, debug=True, host='0.0.0.0')



