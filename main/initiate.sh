#!/bin/bash -login
#SBATCH -p med2                # use 'med2' partition for medium priority
#SBATCH -J CE_genome_assembly               # name for job
#SBATCH -c 32                   # 1 core
#SBATCH -t 24:00:00             # ask for an hour, max
#SBATCH --mem=16000             # memory (2000 mb = 2gb)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zsliu@ucdavis.edu

# initialize conda
. ~/miniconda3/etc/profile.d/conda.sh

# activate your desired conda environment
conda activate VPML

# fail on weird errors
set -e
set -x

### YOUR COMMANDS GO HERE ###
# for example,
#snakemake --cores 4 download_genome
snakemake --cores 32 annotate --use-conda
### YOUR COMMANDS GO HERE ###

# Print out values of the current jobs SLURM environment variables
env | grep SLURM

# Print out final statistics about resource use before job exits
scontrol show job ${SLURM_JOB_ID}

sstat --format 'JobID,MaxRSS,AveCPU' -j ${SLURM_JOB_ID}