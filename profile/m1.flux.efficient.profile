# FLUX overclock settings (most efficient)

# Lock all GPUs Core and Memory clocks
nvtool --setclocks 1305 --setcoreoffset 400 --setmem 5001 

# Change only 7th GPUs Core clock
nvtool --setclocks 1405 -i 6
