#FLUX overclock settings (most efficient)
nvidia-smi -lgc 1305 >> /logs/boot.log
nvidia-smi -lgc 1405 -i 6 >> /logs/boot.log
nvidia-smi -lmc 5000 >> /logs/boot.log

# In HiveOS 

# set Core +270 for all GPUs