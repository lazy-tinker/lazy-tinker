# DYNEX overclock settings (most efficient)

# IMPORTANT: Call nvidia-oc first because it overwrites the nvidia-smi or nvtool lock settings
# ----------------------------------------------------------------------------------------------------------

# Since only 30 Series support locking Memory clock, this is the only way for 10,16 and 20 Series to set Memory clock to 810 Mhz
echo 'CLOCK="-3000"' > /hive-config/nvidia-oc.conf  

# Apply the new nvidia-oc profile
/hive/sbin/nvidia-oc

# This algo allows for extreme Core clock overclock, which undervolts the GPU and lowers the power consumption dramatically
nvtool -i --setcoreoffset 400
