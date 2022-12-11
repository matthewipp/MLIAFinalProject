#!/usr/bin/env bash
#SBATCH -A mlia
#SBATCH -p gpu
#SBATCH --gres=gpu:rtx2080:2
#SBATCH -c 1
#SBATCH -t 00:02:00
#SBATCH -o outputs/trainOutput.txt

module load singularity
module load pytorch/1.12.0

# Set up the list for the training data
cp ../lists/lists_Synapse/train.augmented.txt ../lists/lists_Synapse/train.txt

# Train the model
singularity run --nv /share/resources/containers/singularity/pytorch-1.12.0.sif train.py --root_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size 16 --n_gpu 2 --max_epochs 1000

# Setup the list for the test data
cp ../lists/lists_Synapse/test.augmented.txt ../lists/lists_Synapse/train.txt

# Test the model
singularity run --nv /share/resources/containers/singularity/pytorch-1.12.0.sif test.py --volume_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size 16 --max_epochs 150 --n_gpu 2
