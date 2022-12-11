module load singularity
module load pytorch/1.12.0
singularity run --nv /share/resources/containers/singularity/pytorch-1.12.0.sif train.py --root_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size 16 --n_gpu 2

singularity run --nv /share/resources/containers/singularity/pytorch-1.12.0.sif test.py --volume_path ../Data/augmented --list_dir ../lists/lists_Synapse --num_classes 2 --deterministic 0 --img_size 64 --seed 69420 --vit_patches_size 16 --max_epochs 150 --n_gpu 2
