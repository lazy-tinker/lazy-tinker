#!/bin/bash

FILE="~/onstart.sh"

# Check if th file does not exists
if [ ! -f "$FILE" ]; then
    # Start setting up the container
    apt update; apt install wget nano tmux less xz-utils systemctl -y;

    echo "-------------------- APT PACKGES INSTALLED --------------------"

    cd ~ # Home folder
    
    # Download miner zip file
    wget https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz;
    tar -xf onezerominer-linux-1.2.6.tar.gz; rm onezerominer-linux-1.2.6.tar.gz;

    echo "-------------------- MINER INSTALLED --------------------"

    # Download onstart.sh file
    wget https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.sh; chmod +x onstart.sh

    # Download onstart.service file
    wget -P /etc/systemd/system/ https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.service;

    # Reload systemd Manager Configuration
    sudo systemctl daemon-reload
        
    # Enable and start the service
    sudo systemctl enable onstart.service
    
    echo "-------------------- ONSTART SERVICE INSTALLED --------------------"

    sudo systemctl start onstart.service
    
    echo "-------------------- ONSTART SERVICE STARTED --------------------"
fi
