#!/usr/bin/env bash
#SBATCH -A mlia
#SBATCH -p gpu
#SBATCH --gres=gpu:v100:1
#SBATCH -c 1
#SBATCH -t 00:01:00
#SBATCH -o output.txt

# Any commands after this will be submitted to queue using the 'sbatch' command
# Queues can be listed using the 'squeue --me' command

python3 train.py
