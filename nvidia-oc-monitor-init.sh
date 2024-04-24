#wget -qO- https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/nvidia-oc-monitor-init.sh | bash

cat << 'EOF' | sudo tee /usr/local/bin/nvidia-oc-monitor
#!/bin/bash

# Configuration file URL
configFileUrl="https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/nvidia-oc-monitor.conf"

# Define an associative array for process settings
declare -A processSettings
processSettings[pow-miner-cuda]=810 # Cuda miner for GRAM algo (it coule be different!!)
processSettings[qli-runner]=5001 # Miner for QUBIC algo
processSettings[xelis-taxminer]=5001 # Miner for XEL cryptocurrency

time_interval=60 # Seconds between each loop
oc_change_delay=1 # Delay between resetting and setting OC

# Function to fetch and load settings from the configuration URL
load_config_from_url() {
    if curl -f -s "$configFileUrl" -o "/tmp/processSettings.conf"; then
        while IFS='=' read -r key value; do
            # Trim leading and trailing spaces
            key=$(echo $key | xargs)
            value=$(echo $value | xargs)

            # Skip lines that are empty or start with '#' after trimming
            [[ -z "$key" || $key == \#* ]] && continue

            processSettings["$key"]=$value
        done < "/tmp/processSettings.conf"
        echo "$(date): Successfully loaded configuration."
    else
        echo "$(date): Unable to retrieve configuration. Using default configuration."
    fi
}

# Function to set memory overclocking
set_memory_oc() {
    local process=$1
    local mem_clock=$2

    echo "$(date): Setting memory OC for $process to $mem_clock"
    {
        nvidia-smi -lmc $mem_clock
    } > /dev/null 2>&1
}

# Function to reset overclocking
reset_oc() {
    echo "$(date): Resetting OC to default"
    {
        nvidia-smi -rgc
        nvidia-smi -rmc

        nvidia-smi -pm 1           # Persistance mode
        nvidia-smi -pl 400         # Power limit
        nvidia-smi -gtt 65         # Temperature limit
    } > /dev/null 2>&1
}

# Cleanup function for graceful shutdown
cleanup() {
    echo "$(date): Script is stopping, resetting OC to default..."
    reset_oc
    exit 0
}

# Trap SIGINT and SIGTERM
trap cleanup SIGINT SIGTERM

# Fetch and load the configuration at script start
load_config_from_url

# Main loop
while true; do
    # Reset OC settings at the start of each loop
    reset_oc

    for process in "${!processSettings[@]}"; do
        if pgrep -x "$process" > /dev/null; then
            # Give GPU time between each OC settings change (reset/set)
            sleep $oc_change_delay

            set_memory_oc $process ${processSettings[$process]}
            break # Exit the loop after setting OC for the first running process
        fi
    done

    sleep $time_interval
done
EOF

cat << 'EOF' | sudo tee /etc/systemd/system/nvidia-oc-monitor.service
[Unit]
Description=NVIDIA GPU Overclock Monitoring Service
Requires=nvidia-persistenced.service
After=nvidia-persistenced.service

[Service]
Type=simple
ExecStart=/usr/local/bin/nvidia-oc-monitor
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo chmod +x /usr/local/bin/nvidia-oc-monitor

sudo systemctl enable nvidia-oc-monitor;
sudo systemctl restart nvidia-oc-monitor;
sudo systemctl status nvidia-oc-monitor;
