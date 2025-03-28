FROM python:3.9

USER nischal 

# Set the working directory in the container to /app
# This is where the application code will be stored
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY app.py .
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

CMD [ "python","app.py" ]