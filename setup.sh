#!/bin/bash

# Setup
# docker exec -it [CONTAINER_ID] sh -c 'apt update; apt install wget -y; wget --no-cache -O setup.sh https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/setup.sh && chmod +x setup.sh && ./setup.sh [WALLET_ADDRESS] [ALGO]'

# Cleanup
# docker exec -it 29f887f36049 sh -c 'rm /usr/local/bin/onezerominer-linux/ -r; rm /usr/local/bin/onstart.sh; rm /setup.sh; /opt/nvidia/entrypoint.d/200-custom_scripts.sh'

FILE="/opt/nvidia/entrypoint.d/200-custom_scripts.sh"

# Check if the first argument is empty
if [ -z "$1" ]; then
    echo "Error: The first argument is the wallet address and is required!"
    exit 1
fi

# Check if the second argument is empty
if [ -z "$2" ]; then
    echo "Error: The second argument is the algorithm and is required!"
    exit 1
fi

WALLET="$1"
ALGO="${2^^}"

# Start setting up the container
apt install tmux xz-utils -y

echo "-------------------- APT PACKGES INSTALLED --------------------"

cd /usr/local/bin

if [ "${ALGO,,}" = "dynex" ]; then
    # Cleanup old versions
    rm onezerominer-linux/ -r
fi
if [ "${ALGO,,}" = "nexa" ]; then
    # Cleanup old versions
    rm lolminer/ -r
fi

echo "-------------------- PREVIOUS INSTALATIONS REMOVED --------------------"

# Download miner zip file
if [ "${ALGO,,}" = "dynex" ]; then
    wget --no-cache https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz
    tar -xf onezerominer-linux-1.2.6.tar.gz && rm onezerominer-linux-1.2.6.tar.gz
fi
if [ "${ALGO,,}" = "nexa" ]; then
    wget --no-cache https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.81/lolMiner_v1.81_Lin64.tar.gz;
    tar -xf lolMiner_v1.81_Lin64.tar.gz && rm lolMiner_v1.81_Lin64.tar.gz && mkdir lolminer && mv 1.81/lolMiner lolminer && rm 1.81/ -r
fi

echo "-------------------- MINER PACKAGE INSTALLED --------------------"

# Download onstart.sh file
wget --no-cache -O $FILE https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/onstart.sh
sed -i "s|WALLET=\[WALLET\]|WALLET='$WALLET'|g" $FILE
sed -i "s|ALGO=\[ALGO\]|ALGO='$ALGO'|g" $FILE

echo "-------------------- START SCRIPT INSTALLED --------------------"

chmod +x $FILE
bash $FILE

echo "-------------------- START SCRIPT EXECUTED --------------------"
