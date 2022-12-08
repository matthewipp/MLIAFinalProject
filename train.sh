#!/usr/bin/env bash
#SBATCH -A mlia
#SBATCH -p gpu
#SBATCH --gres=gpu:v100:1
#SBATCH -c 1
#SBATCH -t 00:01:00
#SBATCH -o outputs/trainOutput.txt

# Any commands after this will be submitted to queue using the 'sbatch' command
# Queues can be listed using the 'squeue --me' command

python TransUnet/train.py --root_path [training data path] --dataset Oxide --list_dir (list file of files to use) --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size 32
