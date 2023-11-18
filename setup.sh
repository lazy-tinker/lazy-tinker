#!/bin/bash

# wget https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/setup.sh; chmod +x setup.sh;

# Check if the first argument is empty
if [ -z "$1" ]; then
    echo "Error: The first argument is the wallet address and is required!"
    exit 1
fi

FILE="/usr/local/bin/onstart.sh"

# Check if th file does not exists
if [ ! -f "$FILE" ]; then
    # Start setting up the container
    apt update; apt install wget nano tmux less xz-utils systemctl -y

    echo "-------------------- APT PACKGES INSTALLED --------------------"

    cd /usr/local/bin

    # Cleanup old versions
    rm onezerominer-linux/*
    rmdir onezerominer-linux

    systemctl stop onstart.service
    systemctl disable onstart.service

    rm /etc/systemd/system/onstart.service

    echo "-------------------- PREVIOUS INSTALATIONS REMOVED --------------------"

    # Download miner zip file
    wget --no-cache https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz
    tar -xf onezerominer-linux-1.2.6.tar.gz; rm onezerominer-linux-1.2.6.tar.gz

    echo "-------------------- MINER INSTALLED --------------------"

    # Download onstart.sh file
    wget --no-cache https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.sh; chmod +x onstart.sh

    # Download onstart.service file
    wget --no-cache -P /etc/systemd/system https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.service

    WALLET="$1"
    sed -i "s|ExecStart=/usr/local/bin/onstart.sh \[WALLET\]|ExecStart=/usr/local/bin/onstart.sh $WALLET|" /etc/systemd/system/onstart.service

    # Reload systemd Manager Configuration
    systemctl daemon-reload

    # Enable and start the service
    systemctl enable onstart.service

    echo "-------------------- ONSTART SERVICE INSTALLED --------------------"

    systemctl start onstart.service

    echo "-------------------- ONSTART SERVICE STARTED --------------------"
fi
