#KASPA overclock settings (most efficient)

# IMPORTANT: Set offsets first (Steps 1-5) because calling nvidia-oc overwrites the nvidia-smi lock settings
# ----------------------------------------------------------------------------------------------------------

# 1. Backup the original HiveOS nvidia-oc profile
mv /hive-config/nvidia-oc.conf /hive-config/nvidia-oc.conf.bak

# 2. Generate new temporary nvidia-oc profile
echo 'CLOCK="250"' >> /hive-config/nvidia-oc.conf

# 3. Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

# 4. Delete the temporary nvidia-oc profile
rm /hive-config/nvidia-oc.conf

# 5. Restore the original nvidia-oc profile
mv /hive-config/nvidia-oc.conf.bak /hive-config/nvidia-oc.conf

# 6. Lock the Core and Memory clocks
nvidia-smi -lgc 1440 # GPUs locked at 1440
nvidia-smi -lmc 810 # all GPUs Memory locked at 810 Mhz
