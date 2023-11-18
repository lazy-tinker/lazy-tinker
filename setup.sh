#!/bin/bash

FILE="/onstart.sh"

WALLET="$1"

# Check if th file does not exists
if [ ! -f "$FILE" ]; then
    # Start setting up the container
    apt update; apt install wget nano tmux less xz-utils -y;

    echo "-------------------- PACKGES INSTALLED --------------------"

    wget https://github.com/OneZeroMiner/onezerominer/releases/download/v1.2.6/onezerominer-linux-1.2.6.tar.gz;
    tar -xf onezerominer-linux-1.2.6.tar.gz; rm onezerominer-linux-1.2.6.tar.gz;

    echo "-------------------- MINER INSTALLED --------------------"

    WORKER=$(nvidia-smi -q | grep "Serial Number" | awk '{print $4}')
    echo "cd onezerominer-linux; ./onezerominer -a dynex -o dnx.eu.neuropool.net:19331 -w $WALLET -p $WORKER" > onstart.sh; chmod +x onstart.sh

    echo "-------------------- ONSTART.SH INSTALLED --------------------"
fi

if ! tmux has-session -t miner 2>/dev/null; then
    tmux new -d -s miner
    tmux send-keys -t miner "bash onstart.sh" C-m
    echo "-------------------- TMUX MINER SESSION STARTED --------------------"
fi
