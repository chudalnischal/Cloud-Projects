from shutil import disk_usage

from flask import Flask
from flask import jsonify
import psutil


app = Flask(__name__)

@app.route('/health')
def system_health():
    get_disk = psutil.disk_usage('/')
    health = {
        "cpu_usage" : psutil.cpu_percent(interval=1),
        "mem_usage" : psutil.virtual_memory().percent,
        "disk_usages" : {
            "total" : get_disk.total,
            "used": get_disk.used,
            "available": get_disk.free,
            "percent" : get_disk.percent
        }
    }
    return  jsonify(health)
if __name__ == "__main__":
    app.run(port=5000, host="0.0.0.0", debug=True)

