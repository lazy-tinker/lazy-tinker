# Lock all GPU core clocks at 1440 Mhz
# Set all GPU core offset at 400 Mhz
# Lock all GPU memory clocks at 5001 Mhz
nvtool --setclocks 1440 --setcoreoffset 250 --setmem 5001

# Lock only second GPU core clocks at 1470 Mhz
nvtool -i 1 --setclocks 1470
