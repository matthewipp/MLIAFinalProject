#!/usr/bin/env bash
#SBATCH -A mlia
#SBATCH -p gpu
#SBATCH --gres=gpu:rtx2080:2
#SBATCH -c 1
#SBATCH -t 00:04:00
#SBATCH -o ../outputs/Output.txt

module load singularity
module load pytorch/1.12.0

MAX_EPOCHS=(200 300 400 500 600 700 800 900)
GPUS=2
PATCH_SIZE=16

for EPOCH in ${MAX_EPOCHS[@]}; do

    # Set up the list for the training data
    cp ../lists/lists_Synapse/train.augmented.txt ../lists/lists_Synapse/train.txt

    # Train the model
    singularity run --nv $CONTAINERDIR/pytorch-1.12.0.sif train.py --root_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size $PATCH_SIZE --n_gpu $GPUS --max_epochs $EPOCH

    # Setup the list for the test data
    cp ../lists/lists_Synapse/test.augmented.txt ../lists/lists_Synapse/train.txt

    # Test the model
    singularity run --nv $CONTAINERDIR/pytorch-1.12.0.sif test.py --volume_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size $PATCH_SIZE --max_epochs $EPOCH --n_gpu $GPUS --is_savenii

done
