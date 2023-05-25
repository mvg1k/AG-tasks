#!/bin/bash

# docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# project folder
sudo mkdir /my-app
cd /my-app

# config docker-compose yml
#nginx on 80 port with limits on cpu and ram
#php by default on 9000 port with limimts on cpu and ram
#adding services to one network
cat << EOF | sudo tee docker-compose.yml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    ports:
      - 80:80
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
    networks:
      - overlay_network

  php:
    image: php:fpm
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
    networks:
      - overlay_network

networks:
  overlay_network:
    external: true
EOF

# init swarm 
sudo docker swarm init

# creating network for our services nginx+php
sudo docker network create --driver overlay overlay_network

# running our app
sudo docker stack deploy -c docker-compose.yml my-app
