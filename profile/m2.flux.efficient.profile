#FLUX overclock settings (most efficient)
nvidia-smi -lgc 1300 >> /logs/boot.log
nvidia-smi -lgc 1100 -i 2 >> /logs/boot.log
nvidia-smi -lmc 5000 >> /logs/boot.log
