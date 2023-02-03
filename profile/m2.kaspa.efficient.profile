# KASPA overclock settings (most efficient)

# IMPORTANT: Call nvidia-oc first because it overwrites the nvidia-smi or nvtool lock settings
# ----------------------------------------------------------------------------------------------------------

# Since only 30 Series support locking Memory clock, this is the only way for 10,16 and 20 Series to set Memory clock to 810 Mhz
echo 'CLOCK="-3000"' > /hive-config/nvidia-oc.conf  

# Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

nvtool -i 0 --setclocks 1350 --setcoreoffset 200 --setmem 810 --setmemoffset 0  # 3080
nvtool -i 1 --setclocks 1005  # 1660
nvtool -i 2 --setclocks 1110  # 1660
nvtool -i 3 --setclocks 1260  # 1660 Ti
nvtool -i 4 --setclocks 1260  # 1660 Ti
nvtool -i 5 --setclocks 1470  # 2080 S
nvtool -i 6 --setclocks 1470  # 2080 S
nvtool -i 7 --setclocks 1380  # 2080 Ti
nvtool -i 8 --setclocks 1350 # 2080 Ti
