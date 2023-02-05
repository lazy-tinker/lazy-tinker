# DYNEX overclock settings (most efficient)

# IMPORTANT: Set offsets first (Steps 1-5) because calling nvidia-oc overwrites the nvidia-smi lock settings
# ----------------------------------------------------------------------------------------------------------

# Since 10,16 and 20 Series do not support Memory clock lock, this is the only way to lock Memory clock to 810 Mhz
echo 'MEM="-3000"' > /hive-config/nvidia-oc.conf  

# Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

nvtool -i 0 --setclocks 2100 --setcoreoffset 225 --setfan 40 --setpl 100 --setmem 810 --setmemoffset 0  # 3080
nvtool -i 1 --setclocks 2100 --setcoreoffset 180 --setfan 60 --setpl 70   # 1660
nvtool -i 2 --setclocks 2100 --setcoreoffset 180 --setfan 40 --setpl 70   # 1660
nvtool -i 3 --setclocks 2100 --setcoreoffset 180 --setfan 40 --setpl 70   # 1660 Ti
nvtool -i 4 --setclocks 2100 --setcoreoffset 180 --setfan 40 --setpl 70   # 1660 Ti
nvtool -i 5 --setclocks 2100 --setcoreoffset 100 --setfan 60 --setpl 125  # 2080 S
nvtool -i 6 --setclocks 2100 --setcoreoffset 100 --setfan 40 --setpl 125  # 2080 S
nvtool -i 7 --setclocks 2100 --setcoreoffset 100 --setfan 50 --setpl 100  # 2080 Ti
nvtool -i 8 --setclocks 2100 --setcoreoffset 100 --setfan 40 --setpl 100  # 2080 Ti
