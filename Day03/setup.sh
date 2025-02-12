#!/bin/bash 

#Updating the system
echo "Updating the system"
sudo apt-get update -y

#Enviroment variables 
echo "Setting up the environment variables"
export Grafana_port=3000
export Jenkins_port=8080
export https_port=443
export jenkins_ip=1.1.1.1
Grafana_domain=grafana.local 
Jenkins_domain=jenkins.local

#Installing the required packages
echo "Installing the required packages"
sudo apt-get install -y apache2 apache2-utils
sudo apt-get install -y nginx 
sudo apt-get install -y openssl
echo "Required packages have been installed successfully"

#Installing the required packages for Jenkins
echo "Installing the required packages for Jenkins"
sudo apt-get install -y openjdk-8-jdk
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
   /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
sudo systemctl status jenkins
echo "Jenkins has been installed successfully"

#Installing the required package for Grafana 
echo "Installing the required package for Grafana"
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
echo "Grafana has been installed successfully"

# Updating the system again
echo "Updating the system"
sudo apt-get update -y

# Creating the SSL certificates
echo "Creating the SSL certificates"
sudo mkdir -p /etc/nginx/ssl    
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/jenkins.key -out /etc/nginx/ssl/jenkins.crt -subj "/C=US/ST=CA/L=San Francisco/O=IT/CN=$Jenkins_domain"
echo "Jenkins SSL certificate has been created successfully"

# Creating the htpasswd file for Jenkins
echo "Creating the htpasswd file for Jenkins"
sudo htpasswd -c /etc/nginx/.htpasswd-jenkins admin
echo "htpasswd file has been created successfully"


# Configuring the Ngnix as a reverse proxy server
echo "Configuring the Nginx as a reverse proxy server"
sudo rm /etc/nginx/sites-available/default
sudo tee /etc/nginx/sites-available/default <<EOF 
server {
    listen 80;
    server_name $Grafana_domain $Jenkins_domain;
    
    # Redirect HTTP to HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $Grafana_domain;

    ssl_certificate /etc/nginx/ssl/grafana.crt;
    ssl_certificate_key /etc/nginx/ssl/grafana.key;

    location / {
        proxy_pass http://localhost:$Grafana_port;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}

server {
    listen 443 ssl;
    server_name $Jenkins_domain;

    ssl_certificate /etc/nginx/ssl/jenkins.crt;
    ssl_certificate_key /etc/nginx/ssl/jenkins.key;

    location / {
        proxy_pass http://$jenkins_ip:$Jenkins_port;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        auth_basic "Restricted Jenkins";
        auth_basic_user_file /etc/nginx/.htpasswd-jenkins;
    }
}
EOF
echo "Nginx configuration has been updated successfully"
echo "Restarting the Nginx service"

# Restarting the Nginx service
sudo ngnix -t 
sudo systemctl restart nginx
sudo systemctl status nginx
echo "Nginx service has been restarted successfully"

echo "Setup has been completed successfully"
echo "You can access Jenkins on https://$Jenkins_domain"
echo "You can access Grafana on https://$Grafana_domain"



