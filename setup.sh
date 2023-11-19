#!/bin/bash

# wget https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/setup.sh; chmod +x setup.sh;

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
    apt update; apt install tmux xz-utils -y

    echo "-------------------- APT PACKGES INSTALLED --------------------"

    cd /usr/local/bin

    # Cleanup old versions
    rm onezerominer-linux/*
    rmdir onezerominer-linux

    echo "-------------------- PREVIOUS INSTALATIONS REMOVED --------------------"

    # Download miner zip file
    wget --no-cache https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz
    tar -xf onezerominer-linux-1.2.6.tar.gz; rm onezerominer-linux-1.2.6.tar.gz

    echo "-------------------- MINER PACKAGE INSTALLED --------------------"

    # Download onstart.sh file
    wget --no-cache -P $FILE https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.sh
    sed -i "s|WALLET=\[WALLET\]|WALLET='$WALLET'|g" $FILE

    echo "-------------------- START SCRIPT INSTALLED --------------------"

    chmod +x $FILE
    bash $FILE

    echo "-------------------- START SCRIPT EXECUTED --------------------"
fi
