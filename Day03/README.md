# Deploying Jenkins and Grafana on AWS EC2 with Nginx Reverse Proxy and SSL

## Introduction
In this guide, we will set up Jenkins and Grafana on separate AWS EC2 instances, configure Nginx as a reverse proxy, secure our connections with SSL, and add basic authentication for enhanced security. This setup ensures a streamlined, accessible, and secure DevOps monitoring and automation environment.

---

## Step 1: Launch EC2 Instances
We start by launching two EC2 instances (Amazon Linux 2 or Ubuntu):
- One for Jenkins (CI/CD automation tool)
- One for Grafana (monitoring and visualization tool)

Security groups are configured to allow traffic on:
- **Port 22** for SSH access
- **Port 8080** for Jenkins
- **Port 3000** for Grafana
- **Port 443** for secure HTTPS connections

---

## Step 2: Install Jenkins
To install Jenkins, we add its repository key and update our package list:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
sudo systemctl status jenkins
```

Jenkins helps us automate the software development process, ensuring continuous integration and continuous deployment (CI/CD).

---

## Step 3: Install Java
Jenkins requires Java to run, so we install OpenJDK 17:

```bash
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
```

This verifies that Java is installed and ready.

---

## Step 4: Install Grafana
Grafana is a powerful visualization and monitoring tool. We install it as follows:

```bash
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
```

Grafana will help visualize metrics from various data sources like Prometheus, InfluxDB, and more.

---

## Step 5: Install and Configure Nginx
Nginx is used as a reverse proxy to route traffic securely.

```bash
sudo apt install nginx
```

Modify the Nginx configuration file (`/etc/nginx/sites-available/default`) to enable reverse proxying for Jenkins and Grafana:

```nginx
server {
    listen 80;
    server_name grafana.local jenkins.local;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name grafana.local;
    ssl_certificate /etc/nginx/ssl/certificate.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;
    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location /jenkins {
        proxy_pass http://<ec2-ip>:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

server {
    listen 443 ssl;
    server_name jenkins.local;
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;
    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass http://<JENKINS_EC2_PRIVATE_IP>:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

This ensures secure routing of requests to Jenkins and Grafana.

---

## Step 6: Set Up SSL
To enable HTTPS, we generate self-signed SSL certificates:

```bash
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/grafana.key -out /etc/nginx/ssl/grafana.crt
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/jenkins.key -out /etc/nginx/ssl/jenkins.crt
```

This step ensures encrypted communication between users and the servers.

---

## Step 7: Add Basic Authentication
For additional security, we restrict access using basic authentication:

```bash
sudo apt install apache2-utils
```

Create authentication files:

```bash
sudo htpasswd -c /etc/nginx/.htpasswd-grafana <username>
sudo htpasswd -c /etc/nginx/.htpasswd-jenkins <username>
```

The `auth_basic` directive in the Nginx configuration file ensures only authorized users can access Jenkins and Grafana.

---

## Step 8: Restart Nginx and Test
Apply the changes by restarting Nginx:

```bash
sudo systemctl restart nginx
```

Now, you can access Jenkins and Grafana securely via HTTPS.

---

## Conclusion
This guide covered:
- Deploying **Jenkins and Grafana** on separate EC2 instances
- Setting up **Nginx as a reverse proxy** for secure access
- Configuring **SSL certificates** for encrypted communication
- Adding **basic authentication** for an extra layer of security

With this setup, we ensure a scalable and secure CI/CD pipeline and monitoring infrastructure. 🎯🚀
