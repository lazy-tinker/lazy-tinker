#wget -qO- https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/vastai-price-monitor-init.sh | bash

cat << 'EOF' | sudo tee /usr/local/bin/vastai-price-monitor
#!/bin/bash

update_interval=3600 # 60 minutes
host_id=81587
end_date='7 May 2024 15:00' # Subtracted 3 hours for Local time
discount=0.01
min_price=0.45
records=3

get_available_machines() {
    readarray -t available_machines < <(vastai search offers 'host_id='$host_id' rentable=True' -n --disable-bundling | awk 'NR>1 {gsub(/x$/, "", $3); print $17, $3}')
}

retrieve_average_price() {
    local n_gpus=$1

    # Set the search criteria for available offers
    search_criteria="gpu_name=RTX_4090 num_gpus="$n_gpus" host_id!="$host_id" inet_up>=100 reliability>=0.95 duration>3"

    #vastai search offers "$search_criteria" -o dph

    # Execute the vastai search with the given criteria
    # Sort offers by dollars per hour and disable bundling
    # then, pass the output through awk for processing
    average_price=$(vastai search offers "$search_criteria" -o dph | awk '
        BEGIN {
            # Initialize variables to store the total and count of relevant offerings
            total=0
            count=0
        }
        NR>1 && NR<='$((records+1))' {
            # Take first few records, accumulate the Price values and increment count
            total += $9
            count++
        }
        END {
            printf total/count/'$n_gpus'
        }'
    )

    adjusted_price=$(printf "%.6f" $(echo "$average_price - $discount" | bc -l))
    total_price_avg=$(printf "%.6f" $(echo "$average_price * $n_gpus" | bc -l))
    total_price_adj=$(printf "%.6f" $(echo "$adjusted_price * $n_gpus" | bc -l))

    echo "Average Price: $average_price, Total Price: $total_price_avg"
    echo "Adjusted Price: $adjusted_price, Total Price: $total_price_adj"
}

# Set adjusted price
update_machine_price() {
    local mach_id=$1
    local n_gpus=$2
    local price_gpu=$3
    local unix_date=$(date -d "$end_date" +%s)

    # Check if the price is below the minimum threshold
    if (( $(echo "$price_gpu < $min_price" | bc -l) )); then
        echo "The price is below the minimum threshold of $min_price, skipping listing update"
        return
    fi

    # Set price in VastAi
    vastai list machine $mach_id --price_gpu $price_gpu --price_disk 0.4 --price_inetu 0.0048828125 --price_inetd 0.0048828125 --discount_rate 0 --min_chunk $n_gpus --end_date $unix_date
}

update_prices() {
    local mach_id
    local n_gpus

    # Iterating over the array
    for i in "${available_machines[@]}"
    do
        # Splitting each element into number and status
        read mach_id n_gpus <<< "$i"

        retrieve_average_price $n_gpus

        sleep 5

        update_machine_price $mach_id $n_gpus $adjusted_price

        sleep 5
    done
}

monitor_prices() {
    while true
    do
        get_available_machines

        update_prices

        echo Next price update will be after $(($update_interval/60)) minutes
        sleep $update_interval
    done
}

monitor_prices

EOF

cat << 'EOF' | sudo tee /etc/systemd/system/vastai-price-monitor.service
[Unit]
Description=VastAI Price Monitoring Service
Requires=nvidia-persistenced.service
After=nvidia-persistenced.service

[Service]
Type=simple
Environment=PYTHONPATH=/home/miner/.local/lib/python3.10/site-packages PATH=/home/miner/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ExecStart=/usr/local/bin/vastai-price-monitor
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo chmod +x /usr/local/bin/vastai-price-monitor

sudo systemctl enable vastai-price-monitor;
sudo systemctl restart vastai-price-monitor;
sudo systemctl status vastai-price-monitor;
