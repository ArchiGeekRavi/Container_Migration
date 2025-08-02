#!/bin/bash

# Check if the file exists
if [ ! -f "/etc/docker/daemon.json" ]; then
    echo "Creating new daemon.json file..."
    touch /etc/docker/daemon.json
fi

# Add experimental setting to daemon.json
echo '{' >> /etc/docker/daemon.json
echo '  "experimental": true' >> /etc/docker/daemon.json
echo '}' >> /etc/docker/daemon.json

echo "Changes applied to daemon.json"

# Restart Docker daemon
# poweroff

echo "Restarting Docker daemon..."
sudo systemctl restart docker

echo "Docker daemon restarted"
