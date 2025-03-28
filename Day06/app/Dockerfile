FROM python:alpine

WORKDIR /app

COPY . /app/
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . .

EXPOSE 5000
CMD ["python", "app.py"]
