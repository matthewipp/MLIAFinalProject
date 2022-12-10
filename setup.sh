module load singularity
module load pytorch/1.12.0
alias torch="singularity run --nv $CONTAINERDIR/pytorch-1.12.0.sif "
