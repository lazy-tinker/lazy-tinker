# Use an official base image with apt package manager
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Avoid prompts from apt during build
ARG DEBIAN_FRONTEND=noninteractive

# Update and install wget
RUN apt-get update && apt-get install -y wget

# Add a placeholder for WALLET_ADDRESS and ALGO, which can be replaced at build time
ARG WALLET_ADDRESS=YOUR_ADDRESS
ARG ALGO=YOUR_ALGO

# Download the setup script
RUN wget --no-cache -O setup.sh https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/setup.sh && \
    chmod +x setup.sh

# Execute the setup script with the specified arguments
# Note: The script is executed at build time, might need to adjust based on when you want it to run
RUN ./setup.sh ${WALLET_ADDRESS} ${ALGO}

CMD ["/bin/bash", "-c", "sleep infinity"]

# How to use:
# wget --no-cache -O Dockerfile https://raw.githubusercontent.com/boshk0/HiveOS_GPU_tunner/main/Dockerfile
# replace WALLET_ADDRESS and YOUR_ALGO
# docker build -t miner .
# docker run --rm --name miner -d --gpus all miner
