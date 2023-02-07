# NEXA overclock settings (most efficient)

nvtool -i 0 --setclocks 1470 --setcoreoffset 255 --setpl 180 --setmem 5001         # 3080
nvtool -i 1 --setclocks 1470 --setcoreoffset 120 --setpl 70  --setmemoffset -1500  # 1660
nvtool -i 2 --setclocks 1470 --setcoreoffset 120 --setpl 70  --setmemoffset -1500  # 1660
nvtool -i 3 --setclocks 1470 --setcoreoffset 90  --setpl 70  --setmemoffset -1500  # 1660 Ti
nvtool -i 4 --setclocks 1470 --setcoreoffset 90  --setpl 70  --setmemoffset -1500  # 1660 Ti
nvtool -i 5 --setclocks 1470 --setcoreoffset 120 --setpl 125 --setmemoffset -1500  # 2080 S
nvtool -i 6 --setclocks 1470 --setcoreoffset 120 --setpl 125 --setmemoffset -1500  # 2080 S
nvtool -i 7 --setclocks 1470 --setcoreoffset 120 --setpl 125 --setmemoffset -1500  # 2080 Ti
nvtool -i 8 --setclocks 1470 --setcoreoffset 120 --setpl 125 --setmemoffset -1500  # 2080 Ti
