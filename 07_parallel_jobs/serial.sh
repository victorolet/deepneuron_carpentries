#!/bin/bash
# ============================================================
# serial.sh — Run Amdahl with a single CPU (serial baseline)
#
# Submit: sbatch serial.sh
# This is the t₁ baseline for the scaling study.
# ============================================================

#SBATCH -J amdahl-serial
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

module purge
module load Python

echo "=== Serial Amdahl run ==="
echo "Node: $(hostname)"
echo "CPUs: $SLURM_NTASKS"
echo "Started: $(date)"
echo ""

amdahl

echo ""
echo "Finished: $(date)"
