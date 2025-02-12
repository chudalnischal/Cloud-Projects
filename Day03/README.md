# Day 03 Challenge: Setting Up Jenkins and Grafana with Nginx Reverse Proxy and SSL

Today, I worked on setting up two EC2 instances for Jenkins and Grafana, configured security groups, installed necessary software, and set up Nginx as a reverse proxy with SSL for enhanced security. Below is a detailed breakdown of the tasks completed:

---

## Tasks Completed

### 1. **Created Two EC2 Instances**
   - Launched two EC2 instances:
     - **Instance 1**: For Jenkins.
     - **Instance 2**: For Grafana.
   - Both instances were configured with appropriate security groups.

---

### 2. **Configured Security Groups**
   - Opened the following ports in the security groups:
     - **SSH (Port 22)**: For remote access to the instances.
     - **Jenkins (Port 8080)**: For accessing the Jenkins server.
     - **Grafana (Port 3000)**: For accessing the Grafana dashboard.
     - **HTTPS (Port 443)**: For secure communication via SSL.

---

### 3. **Installed Jenkins and Grafana**
   - **Jenkins Server**:
     - Updated the system packages.
     - Installed Jenkins using the official installation guide.
     - Started and enabled the Jenkins service.
   - **Grafana Server**:
     - Updated the system packages.
     - Installed Grafana using the official installation guide.
     - Started and enabled the Grafana service.

---

### 4. **Installed and Configured Nginx as a Reverse Proxy**
   - Installed Nginx on the **Grafana server**.
   - Configured Nginx to act as a reverse proxy for both Jenkins and Grafana.
   - Modified the Nginx configuration file to:
     - Redirect HTTP traffic to HTTPS for enhanced security.
     - Proxy requests to Jenkins (port 8080) and Grafana (port 3000).

---

### 5. **Set Up SSL for Secure Communication**
   - Installed and configured an SSL certificate using Let's Encrypt or a similar service.
   - Added the SSL certificate to the Nginx configuration file.
   - Ensured that all traffic is redirected to HTTPS.

---

### 6. **Added Basic Authentication**
   - Installed `apache2-utils` to create basic authentication for added security.
   - Created a username and password for accessing Jenkins and Grafana.
   - Added the authentication details to the Nginx configuration file.

---

### 7. **Tested the Setup**
   - Verified that:
     - Jenkins is accessible via `https://jenkins.local`.
     - Grafana is accessible via `https://grafana.local`.
     - HTTP traffic is redirected to HTTPS.
     - Basic authentication is working as expected.

---
