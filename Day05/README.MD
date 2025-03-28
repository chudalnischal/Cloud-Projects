# Day 5: Dockerized Web Applications (Nginx and Flask)

## Overview
On Day 5, I worked with Docker to containerize two web applications:
- Nginx serving static content
- Flask serving dynamic content

Both applications are containerized separately but can run together in a Docker environment, demonstrating Docker's multi-container capabilities.

## 🧠 What I Learned
- **Docker with Nginx**: Setting up a static web page in an Nginx container
- **Docker with Flask**: Containerizing a Python Flask web application
- **Combining Containers**: Running multiple containers simultaneously
- **Port Management**: Exposing different ports for host system access

## 📂 Project Structure

### 1. `nginx-docker/`
Nginx-based web server serving static HTML content:
- `Dockerfile`: Nginx container configuration
- `index.html`: Static HTML content

### 2. `Python-Docker/`
Flask-based web application:
- `app.py`: Flask application code
- `Dockerfile`: Flask container configuration
- `requirements.txt`: Python dependencies

## ⚙️ Technical Setup

### Nginx Configuration
**Dockerfile Steps:**
1. Base image: `nginx:latest`
2. Working directory: `/home`
3. Copies `index.html` to `/usr/share/nginx/html/`
4. Exposes port 80
5. Starts Nginx server

### Flask Configuration
**Dockerfile Steps:**
1. Base image: `python:3.9`
2. Creates non-root user `nischal`
3. Working directory: `/app`
4. Copies `app.py` and `requirements.txt`
5. Installs dependencies via `pip`
6. Exposes port 80
7. Runs Flask app

## 🚀 How to Run

### Prerequisites
- Docker installed on your system

### Nginx Application
```bash
cd nginx-docker
docker build -t nginx-docker-app .
docker run -d -p 8081:80 nginx-docker-app
```
Access at: http://localhost:8081

### Flask Application
```bash
cd Python-Docker
docker build -t flask-docker-app .
docker run -d -p 8080:80 flask-docker-app
```
Access at: http://localhost:8080

### Running Both Containers
 Nginx on port 8081
 docker run -d -p 8081:80 nginx-docker-app

 Flask on port 8080
 docker run -d -p 8080:80 flask-docker-app

### ✅ Expected Output
Nginx: 🚀 "Hello from Nginx inside a Docker container!"

Flask: "Hello, World!"

## 🏁 Conclusion
This project demonstrates Docker's capability to containerize both static (Nginx) and dynamic (Flask) web applications. Docker provides:
- Isolated environments
- Easy deployment
- Concurrent running of different services
- Simplified dependency management
- Perfect for modern web application deployment!