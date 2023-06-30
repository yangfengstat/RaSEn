#!/bin/sh

#SBATCH --job-name=ex
#SBATCH --time=12:00:00
#SBATCH --tasks-per-node=1
#SBATCH --mem=32g
#SBATCH --cpus-per-task=8
#SBATCH --array=1-4

export OMP_NUM_THREADS=1
module load r/intel/4.0.4
R CMD BATCH --no-save --no-restore sim_summary.R script_$SLURM_ARRAY_TASK_ID