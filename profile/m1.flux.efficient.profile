# FLUX overclock settings (most efficient)

# IMPORTANT: Set offsets first (Steps 1-5) because calling nvidia-oc overwrites the nvidia-smi lock settings
# ----------------------------------------------------------------------------------------------------------

# 1. Backup the original HiveOS nvidia-oc profile
mv /hive-config/nvidia-oc.profile /hive-config/nvidia-oc.profile.bak

# 2. Generate new temporary nvidia-oc profile
echo 'CLOCK="400"' >> /hive-config/nvidia-oc.profile

# 3. Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

# 4. Delete the temporary nvidia-oc profile
rm /hive-config/nvidia-oc.profile

# 5. Restore the original nvidia-oc profile
mv /hive-config/nvidia-oc.profile.bak /hive-config/nvidia-oc.profile

# 6. Lock the Core and Memory clocks
nvidia-smi -lgc 1305 # all GPUs Core locked at 1305 Mhz
nvidia-smi -lgc 1405 -i 6 # 7th GPU locked at 1405
nvidia-smi -lmc 5000 # all GPUs Memory locked at 5000 Mhz
