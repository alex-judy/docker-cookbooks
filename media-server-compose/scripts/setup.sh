#!/bin/bash
#Installs docker and docker-compose v2 and copies configured files to user's home directory.

DOCKER_DIR="$HOME/docker"

echo "Updating..."
sudo apt-get update

echo "Installing docker dependencies and services..."
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

sudo curl -fsSL https://get.docker.com -o get-docker.sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce

mkdir -p $HOME/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose

echo "Adding $USER to docker group..."
sudo usermod -aG docker $USER

chmod +x ~/.docker/cli-plugins/docker-compose
docker compose version 

echo "Starting docker service..."
sudo service docker start

echo "Copying .bash_aliases to $HOME..."
sudo cp ../.bash_aliases $HOME
source ~/.bashrc

echo "New docker folder created at $DOCKER_DIR..."
mkdir $DOCKER_DIR

echo "New bin folder created at $HOME/bin"
mkdir $HOME/bin

echo "Docker garbage collector setup..."
mkdir -p $USERDIR/docker/configs/docker-gc
cd $USERDIR/docker/configs/docker-gc
wget https://raw.githubusercontent.com/clockworksoul/docker-gc-cron/master/compose/docker-gc-exclude
cd ~

echo "Setting docker folder permissions..."
sudo setfacl -Rdm g:docker:rwx $DOCKER_DIR
sudo chmod -R 775 $DOCKER_DIR

echo "Copying files to $DOCKER_DIR..."
cp compose-files/. $DOCKER_DIR/compose-files

echo "Copying scripts to $HOME/bin"
cp . $HOME/bin

echo "Creating shared docker folder..."
mkdir $DOCKER_DIR/shared

echo "Creating traefik file/folder structure..."
mkdir $DOCKER_DIR/traefik
mkdir $DOCKER_DIR/traefik/acme
mkdir $DOCKER_DIR/traefik/rules
touch $DOCKER_DIR/traefik/acme/acme.json
touch $DOCKER_DIR/traefik/traefik.log

echo "Setting acme.json permissions..."
sudo chmod 600 $DOCKER_DIR/traefik/acme/acme.json

echo "Creating docker networks..."
docker network create --gateway 192.168.50.1 --subnet 192.168.50.0/24 traefik_proxy
docker network create --gateway 192.168.100.1 --subnet 192.168.100.0/24 socket_proxy
docker network create influxdb

docker compose -f $HOME/docker/compose-files/network/network-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/bittor/bittor-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/database/database-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/indexers/indexers-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/management/management-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/monitoring/monitoring-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/media/media-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/other/other-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/pvr/pvr-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/security/security-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/smarthome/smarthome-compose.yml up -d --force-recreate 
docker compose -f $HOME/docker/compose-files/utility/utility-compose.yml up -d --force-recreate

sudo chown -R 1000:1000 ~/docker/configs/grafana
