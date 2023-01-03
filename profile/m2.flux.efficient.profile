#FLUX overclock settings (most efficient)
nvidia-smi -lgc 1300 >> /logs/boot.log
nvidia-smi -lgc 960 -i 2 >> /logs/boot.log
nvidia-smi -lmc 5000 >> /logs/boot.log

# In HiveOS 

# Set Core offset to 200 for 0,1,3 GPU and PL to 115
# Set Core offset to 100 for 2,4,5,6 GPU
# Set PL to 88 for 4,5,6 GPU and 150 for 2

