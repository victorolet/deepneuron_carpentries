#!/bin/bash
# ============================================================
# Solution: Exercise 5
# ============================================================

#SBATCH -J vars-solution
#SBATCH -N 1
#SBATCH -n 2
#SBATCH -t 00:01:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

cd $SLURM_SUBMIT_DIR

echo "Job ID:   $SLURM_JOB_ID"
echo "Tasks:    $SLURM_NTASKS"
echo "Node:     $(hostname)"

DATADIR=/scratch/pawseyXXXX/$USER
echo "DATADIR:  $DATADIR"

echo "PATH:     $PATH"

env | grep SLURM
