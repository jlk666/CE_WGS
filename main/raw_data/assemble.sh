#!/bin/bash -login
#SBATCH -p med2                # use 'med2' partition for medium priority
#SBATCH -J Assemble          # name for job
#SBATCH -c 16                   # 16 core
#SBATCH -t 24:00:00             # 
#SBATCH --mem=16000             # 16 GB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zsliu@ucdavis.edu

# initialize conda
. ~/miniconda3/etc/profile.d/conda.sh

# activate your desired conda environment
conda activate spades

# fail on weird errors
set -e
set -x

### YOUR COMMANDS GO HERE ###
# for example,
spades.py -1 CE1_S55_L002_R1_001.fastq.gz -2 CE1_S55_L002_R2_001.fastq.gz \
           -o spades-careful-assembly2 -t 6 --only-assembler \
          --careful
### YOUR COMMANDS GO HERE ###

# Print out values of the current jobs SLURM environment variables
env | grep SLURM

# Print out final statistics about resource use before job exits
scontrol show job ${SLURM_JOB_ID}

sstat --format 'JobID,MaxRSS,AveCPU' -j ${SLURM_JOB_ID}