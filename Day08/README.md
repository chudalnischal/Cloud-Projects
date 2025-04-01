# Docker Network Setup for Yelb Application

This repository provides instructions for setting up a multi-container application environment using Docker. The application includes the following services:
- Redis
- PostgreSQL
- Yelb App Server
- Yelb UI
These containers are configured to run on the same Docker network, allowing them to communicate with each other.

## Overview
This project demonstrates how to deploy four services (Redis, PostgreSQL, Yelb app server, and Yelb UI) on the same network in Docker. The application is split into multiple components, each running in its own container. By connecting them to the same Docker network, the services can communicate and work together seamlessly.

### Services:
1. **Redis**: A fast, in-memory data store used by the app server for caching.
2. **PostgreSQL**: A relational database used to store application data.
3. **Yelb App Server**: The core backend service that handles business logic and data operations.
4. **Yelb UI**: The frontend user interface that interacts with the app server.

## Prerequisites
Before setting up the containers, you need to have the following installed:
- **Docker**: [Installation guide](https://docs.docker.com/get-docker/)
- **Docker Compose** (if using Docker Compose): [Installation guide](https://docs.docker.com/compose/install/)
---
## Without Docker Compose Setup
You can manually set up the containers without Docker Compose. Follow the steps below:

1. **Create a Custom Network**:
   First, create a custom Docker network to allow containers to communicate with each other:
```bash
   docker network create mynetwork
``` 

2. **Run the Containers**: 
Run each container on the custom network, ensuring all services are connected:
```bash
# Redis:
docker run --network=mynetwork --name redis redis:latest
# PostgreSQL:
docker run --network=mynetwork --name postgres postgres:latest
#Yelb App Server:
docker run --network=mynetwork --name yelb-app-server yelb-app-server-image
#Yelb UI:
docker run --network=mynetwork --name yelb-ui yelb-ui-image
```
Each of these containers will now be on the same mynetwork and able to communicate with each other.
---
## With Docker Compose Setup
Alternatively, you can simplify the process by using Docker Compose. The docker-compose.yml file below defines the services and the network:

**Create a docker-compose.yml File**:
 Create the following docker-compose.yml file:

```yaml
version: '3'
services:
  redis:
    image: redis:latest
    networks:
      - mynetwork
    ports:
      - "6379:6379"  # Default Redis port

  postgres:
    image: postgres:latest
    networks:
      - mynetwork

    ports:
      - "5432:5432"  # Default PostgreSQL port

  yelb-app-server:
    image: yelb-app-server-image  # Replace with the correct image
    networks:
      - mynetwork
    ports:
      - "3000:3000"  # Assuming the Yelb app server runs on port 3000

  yelb-ui:
    image: yelb-ui-image  # Replace with the correct image
    networks:
      - mynetwork
    ports:
      - "80:80"  # Default port for web traffic (HTTP)

networks:
  mynetwork:
    driver: bridge

```
**Start the Application**: Use the following command to start all containers defined in the docker-compose.yml file:
```bash
docker-compose up -d
#This will automatically create the mynetwork network and run the containers on that network.
```

### Explanation of Services
- **Redis**: A fast, in-memory database often used for caching and session management. It helps speed up responses by reducing database load.

- **PostgreSQL**: A relational database management system (RDBMS) used for storing and querying structured data.

- **Yelb App Server**: The backend of the Yelb application, responsible for business logic, API requests, and interactions with Redis and PostgreSQL.

- **Yelb UI**: The frontend part of the application, providing a user interface for interacting with the backend.

All these containers are connected to the same Docker network (mynetwork), allowing them to communicate with each other using their service names (redis, postgres, yelb-app-server, yelb-ui) as hostnames.

### How to Access the Application
**Yelb UI**: After deploying the containers, you can access the Yelb UI by visiting http://localhost:<port> in your browser. Replace <port> with the port the Yelb UI is mapped to on your host machine (typically set in your Docker configuration).
**Redis & PostgreSQL**: These services run in the background and aren't exposed to the host machine by default. They can only be accessed by other containers within the same network.

### Notes
Docker Compose simplifies the process by managing container relationships and networks in a single file, which is especially helpful for complex setups.
If you're using Docker without Compose, remember that you have to manually manage the network and ensure all containers are connected correctly.
The application services can be accessed through container names, which resolve to their respective IP addresses within the network.
---