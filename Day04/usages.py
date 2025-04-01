import sys
import time
import psutil  # type: ignore


def system():
    print("Monitoring CPU and Memory usages of Device")
    print("-------------------------------------------")

    try:
        while True:
            cpu = psutil.cpu_percent(interval=1)
            memory = psutil.virtual_memory()

            print(f"CPU Usage: {cpu}%")
            print(f"Memory Usage: {memory.percent}%")
            print("-------------------------------------------")

            #waiting some time to print it again 
            time.sleep(5)
    except KeyboardInterrupt:
        sys.exit()


if __name__ == "__main__": 
    system()