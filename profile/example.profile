# Lock core clock by GPU index (0 - first)
nvidia-smi -i 0 -lgc 1425
nvidia-smi -i 1 -lgc 1440
nvidia-smi -i 2 -lgc 1110
nvidia-smi -i 3 -lgc 1410
nvidia-smi -i 4 -lgc 1320

# Lock memory clock of all GPUs
nvidia-smi -lmc 5000
