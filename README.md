# Inception Project

## Table of Contents
- [About](#about)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Volumes & Network](#volumes--network)
- [Security](#security)
- [WP-CLI](#wp-cli)
- [Useful Commands](#useful-commands)

---

## About

The **Inception** project is an infrastructure project designed to build a secure, isolated, and containerized environment using **Docker Compose**. It includes the configuration of services such as **NGINX**, **WordPress**, and **MariaDB**, all hosted within a **virtual machine** under strict technical and security rules.

---

## Project Structure
```
Inception/
├── srcs/
│ ├── docker-compose.yml
│ └── requirements/
│ ├── nginx/
│ │ ├── Dockerfile
│ │ └── tools
│ │ └── nginx.conf
│ ├── wordpress/
│ │ ├── Dockerfile
│ │ └── setup.sh
│ └── mariadb/
│ ├── Dockerfile
│ └── setup_mariadb.sh
│ └── 50-server.cnf
├── .env
└── Makefile

```
## Setup Instructions

### 1. Prerequisites
- Virtual Machine (Linux-based)
- Docker, Docker Compose, Make
- Proper port forwarding (4242, 80, 443)

### 2. Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd inception

# Build and run containers
make
```
Access
HTTPS: https://<your-login>.42.fr
SSH: ssh <your-login>@localhost -p 4242

## Volumes & Network

### Volumes:

WordPress files: /home/akrepkov/data/wordpress

WordPress DB: /home/akrepkov/data/mariadb

### Network:

All containers are connected via a custom bridge network inception.

## Security
Only port 443 is exposed (HTTPS).

TLSv1.2 or TLSv1.3 only.

Self-signed certificate is created inside the NGINX Dockerfile.

Admin username must not contain admin, administrator, etc.

Passwords must not be hardcoded.

Use Docker secrets and .env to manage credentials securely.

## WP-CLI
WP-CLI is used to automate WordPress setup:
```
# Example usage inside WordPress container
wp core download --allow-root
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER ...
wp core install --url=$DOMAIN_NAME ...
wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD"
```

## Useful Commands
### System Setup (Local / VM)
```
# Remove Apache (conflicts with Nginx)
sudo apt-get --purge remove apache2

# Install Nginx
sudo apt update
sudo apt install nginx

# Install PHP and FPM
sudo apt install php php-fpm php-mysql

# Install MariaDB
sudo apt install mariadb-server

# Secure MariaDB
sudo mysql_secure_installation
```

### Nginx Configuration
```
# Remove default site config
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default

# Create a new virtual host
sudo nano /etc/nginx/sites-available/your-domain.com

# Enable the site
sudo ln -s /etc/nginx/sites-available/your-domain.com /etc/nginx/sites-enabled/

# Test Nginx config
sudo nginx -t

# Restart Nginx
sudo systemctl reload nginx
```

### HTTPS Setup (Self-signed cert)
```
# Create self-signed certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt

# Generate SSL snippets
sudo nano /etc/nginx/snippets/self-signed.conf
sudo nano /etc/nginx/snippets/ssl-params.conf

# Reload Nginx
sudo systemctl reload nginx
```

### Docker Commands
```
# Build image from Dockerfile
docker build -t myweb .

# Run container on port 8080
docker run -d -p 8080:80 --name myweb-container myweb

# Check running containers
docker ps

# Stop & remove container
docker stop myweb-container
docker rm myweb-container
# OR force remove
docker rm -f <container_id>

# List images
docker images

# Pull base Nginx image
docker pull nginx:latest
```

### Docker Compose for Multi-Container
```
# docker-compose.yml should be created first
docker-compose up -d         # Run in background
docker-compose down          # Stop and remove containers
```

### Database Access
```
# Access MariaDB CLI
sudo mysql -u root -p
```

### Host & NAT Setup
```
# Modify /etc/hosts to resolve custom domain locally
sudo nano /etc/hosts
# Example:
# 127.0.0.1 your-domain.com
```










