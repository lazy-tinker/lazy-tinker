#!/bin/bash

# Setup
# sudo docker exec -it [CONTAINER_ID] sh -c 'apt update; apt install wget -y; wget --no-cache -O setup.sh https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/setup.sh && chmod +x setup.sh && ./setup.sh [WALLET_ADDRESS]'

# Cleanup
# sudo docker exec -it 29f887f36049 sh -c 'systemctl stop onstart.service && systemctl disable onstart.service && rm /etc/systemd/system/onstart.service; rm /usr/local/bin/onezerominer-linux/*; rmdir /usr/local/bin/onezerominer-linux; rm /usr/local/bin/onstart.sh; rm /setup.sh; /opt/nvidia/entrypoint.d/200-custom_scripts.sh'

FILE="/opt/nvidia/entrypoint.d/200-custom_scripts.sh"

# Check if the file hasn't already been set
if [ ! -f "$FILE" ]; then

    # Check if the first argument is empty
    if [ -z "$1" ]; then
        echo "Error: The first argument is the wallet address and is required!"
        exit 1
    fi

    WALLET="$1"

    # Start setting up the container
    apt install tmux xz-utils -y

    echo "-------------------- APT PACKGES INSTALLED --------------------"

    cd /usr/local/bin

    # Cleanup old versions
    rm onezerominer-linux/* && rmdir onezerominer-linux

    echo "-------------------- PREVIOUS INSTALATIONS REMOVED --------------------"

    # Download miner zip file
    wget --no-cache https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz
    tar -xf onezerominer-linux-1.2.6.tar.gz && rm onezerominer-linux-1.2.6.tar.gz

    echo "-------------------- MINER PACKAGE INSTALLED --------------------"

    # Download onstart.sh file
    wget --no-cache -O $FILE https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.sh
    sed -i "s|WALLET=\[WALLET\]|WALLET='$WALLET'|g" $FILE

    echo "-------------------- START SCRIPT INSTALLED --------------------"

    chmod +x $FILE
    bash $FILE

    echo "-------------------- START SCRIPT EXECUTED --------------------"
fi
