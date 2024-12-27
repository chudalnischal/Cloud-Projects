FROM python:3.9-slim

# setting the working directory
WORKDIR /app

# copying all files 
COPY . /app

# installing the depensencies
RUN pip install -r requirements.txt 
EXPOSE 5000

CMD ["python", "main.py"]