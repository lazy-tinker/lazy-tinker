#!/bin/bash

WALLET=[WALLET]
ALGO=[ALGO]

if ! tmux has-session -t miner 2>/dev/null; then
    WORKER=$(nvidia-smi -q -i 0 | grep 'Serial Number' | awk '{print $4}')

    tmux new -d -s miner

    if [ "${ALGO,,}" = "dynex" ]; then
        tmux send-keys -t miner "cd /usr/local/bin/onezerominer-linux; ./onezerominer -a dynex -o dnx.eu.neuropool.net:19331 -w $WALLET -p $WORKER" C-m
    fi
    if [ "${ALGO,,}" = "nexa" ]; then
        tmux send-keys -t miner "cd /usr/local/bin/lolminer; ./lolMiner -a NEXA -p stratum+tcp://nexapow.auto.nicehash.com:9200 -u $WALLET.$WORKER" C-m
    fi
    
fi
