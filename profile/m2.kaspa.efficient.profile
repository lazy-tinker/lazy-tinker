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

nvtool -i 0 --setclocks 1350 --setcoreoffset 200 --setmem 810 --setmemoffset 0  # 3080
nvtool -i 1 --setclocks 1005  # 1660
nvtool -i 2 --setclocks 1110  # 1660
nvtool -i 3 --setclocks 1260  # 1660 Ti
nvtool -i 4 --setclocks 1260  # 1660 Ti
nvtool -i 5 --setclocks 1470  # 2080 S
nvtool -i 6 --setclocks 1470  # 2080 S
nvtool -i 7 --setclocks 1380  # 2080 Ti
nvtool -i 8 --setclocks 1350 # 2080 Ti
