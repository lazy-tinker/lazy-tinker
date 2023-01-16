# KASPA overclock settings (most efficient)

# IMPORTANT: Set offsets first (Steps 1-5) because calling nvidia-oc overwrites the nvidia-smi lock settings
# ----------------------------------------------------------------------------------------------------------

# 1. Backup the original HiveOS nvidia-oc profile
mv /hive-config/nvidia-oc.conf /hive-config/nvidia-oc.conf.bak

# 2. Generate new temporary nvidia-oc profile
echo 'CLOCK="-3000"' >> /hive-config/nvidia-oc.conf  # Since 16 and 20 Series don't support Memory clock lock, this is another way to set Memory clock to 810 Mhz

# 3. Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

# 4. Delete the temporary nvidia-oc profile
rm /hive-config/nvidia-oc.conf

# 5. Restore the original nvidia-oc profile
mv /hive-config/nvidia-oc.conf.bak /hive-config/nvidia-oc.conf

# 6. Lock the Core and Memory clocks
nvidia-smi -lgc 1005 -i 0  # 1660  (7.0 Mh/s/W)
nvidia-smi -lgc 1110 -i 1  # 1660  (8.2 Mh/s/W)
nvidia-smi -lgc 1260 -i 2  # 1660 Ti  (7.6 Mh/s/W)
nvidia-smi -lgc 1260 -i 3  # 1660 Ti  (5.6 Mh/s/W)
nvidia-smi -lgc 1470 -i 4  # 2080 S  (5.9 Mh/s/W)
nvidia-smi -lgc 1470 -i 5  # 2080 S  (5.8 Mh/s/W)
nvidia-smi -lgc 1380 -i 6  # 2080 Ti  (6.5 Mh/s/W)
nvidia-smi -lgc 1350 -i 7  # 2080 Ti  (5.4 Mh/s/W)
