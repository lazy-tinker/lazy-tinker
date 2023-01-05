# FLUX overclock settings (most efficient)

# IMPORTANT: Set Core Offsets first because nvidia-oc overwrites the nvidia-smi settings
# --------------------------------------

# Backup the original HiveOS nvidia-oc profile
mv /hive-config/nvidia-oc.profile /hive-config/nvidia-oc.profile.bak

# Generate new temporary nvidia-oc profile
echo 'CLOCK="400"' >> /hive-config/nvidia-oc.profile

# Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

# Delete the temporary nvidia-oc profile
rm /hive-config/nvidia-oc.profile

# Restore the original nvidia-oc profile
mv /hive-config/nvidia-oc.profile.bak /hive-config/nvidia-oc.profile

# Lock the Core and Memory clocks
nvidia-smi -lgc 1305 >> /logs/boot.log
nvidia-smi -lgc 1405 -i 6 >> /logs/boot.log
nvidia-smi -lmc 5000 >> /logs/boot.log
