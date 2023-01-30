# KASPA overclock settings (most efficient)

nvtool -i 0 --setclocks 1350 --setmem 810 --setcoreoffset 200  # 3080
nvtool -i 1 --setclocks 1005 --setmemoffset  # 1660
nvtool -i 2 --setclocks 1110 --setmemoffset  # 1660
nvtool -i 3 --setclocks 1260 --setmemoffset  # 1660 Ti
nvtool -i 4 --setclocks 1260 --setmemoffset  # 1660 Ti
nvtool -i 5 --setclocks 1470 --setmemoffset  # 2080 S
nvtool -i 6 --setclocks 1470 --setmemoffset  # 2080 S
nvtool -i 7 --setclocks 1380 --setmemoffset  # 2080 Ti
nvtool -i 8 --setclocks 1350 --setmemoffset  # 2080 Ti
