#!/bin/bash
# ============================================================
# Solution: Exercise 7
# ============================================================

#SBATCH -J python-version
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:01:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

module purge
module load Python    # or use full version string: Python/3.11.3-GCCcore-12.3.0

which python3
python3 --version
