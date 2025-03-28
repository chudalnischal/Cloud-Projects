# Day 06 Learning Docker Compose with Flask and MongoDB

This project documents my learning journey with Docker Compose. I built a simple Flask application, created a Dockerfile, a requirements.txt, and a Docker Compose file to integrate it with MongoDB. Additionally, I explored how to modify data through the terminal, check container logs, and understand the importance of bind networking.

## Project Overview

1. Flask Application
 - Created a basic Flask web application with two endpoints:
   / → Returns a welcome message.
   /data → Retrieves data from MongoDB.

2. Dockerfile
 - Built a Dockerfile to containerize the Flask application.

3. Requirements.txt
 - Included necessary Python packages like Flask and PyMongo.

4. Docker Compose
- Developed a docker-compose.yml file to run both the Flask and MongoDB containers.
- Used volume mounts to persist MongoDB data.
- Set up environment variables for easier development.

## Key Learnings

🔎 Modifying Data Through Terminal
- Accessed the MongoDB container using the terminal with the following command:
```bash
docker exec -it <mongo_container_name> mongosh
```
Selected the database and inserted sample data:
```bash
use testdb
db.testcollection.insertOne({ name: "Alice", age: 30 })
```
Verified the data using:
```bash
db.testcollection.find({})
```
📜 Checking Container Logs
Monitored the logs of both the Flask and MongoDB containers using:
```bash
docker-compose logs web
docker-compose logs mongo
```
Used -f to follow the logs in real time:
```bash
docker-compose logs -f
```
## Importance of Bridge Networking in Docker Compose

Docker Compose creates a bridge network by default, allowing containers to communicate with each other using service names. This provides network isolation, meaning containers can only communicate within the defined network unless explicitly exposed.In the Flask app, I used the service name mongo instead of localhost to connect to MongoDB:
```bash
client = MongoClient('mongodb://mongo:27017/')
```
Bridge networking simplifies service discovery, making inter-container communication seamless.

## 📦 Importance of Volumes in Docker Compose

Volumes are used to persist data beyond the container lifecycle.
In this project, I created a volume for MongoDB using Docker Compose:
```bash
volumes:
  mongodb_data:/data/db
```
This ensures data remains intact even if the MongoDB container is restarted or removed.
Volumes are crucial for managing application state, debugging, and data recovery.

## Conclusion
This project gave me a solid understanding of Docker Compose and how it simplifies managing multi-container applications. From building containers to checking logs and interacting with services via the terminal, I now feel confident using Docker Compose for future projects.

Happy Dockering! 🚀

