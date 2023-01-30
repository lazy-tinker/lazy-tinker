# NEXA overclock settings (most efficient)

# Lock all 3060 Ti and 3080 Core and Memory clocks
nvtool --setclocks 1300 --setcoreoffset 400 --setmem 5001 

# Change only 3080 GPUs Core clock
nvtool -i 6 --setclocks 1405
