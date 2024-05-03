#!/bin/bash

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common openssh-client openssh-server criu
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
wget https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz
tar xzvf docker-17.04.0-ce.tgz
sudo cp  -r docker/* /usr/bin/
sudo dockerd &
