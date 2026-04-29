#!/bin/bash

# 1. Update and Install Docker/Git
apt-get update -y
apt-get install -y docker.io docker-compose-v2 git

# 2. Start Docker service
systemctl start docker
systemctl enable docker

# 3. Fix permissions so you don't need 'sudo' for docker commands
usermod -aG docker ubuntu

# 4. Clone your project
mkdir -p /opt/app
git clone https://github.com/SarahBee99/tf-ec2-docker.git /opt/app

# 5. Deploy the app
cd /opt/app
docker compose up --detach
