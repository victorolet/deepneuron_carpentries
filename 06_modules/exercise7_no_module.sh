#!/bin/bash
# ============================================================
# Exercise 7 Bonus — What happens WITHOUT module load?
#
# This script intentionally does NOT load Python.
# Submit it and observe the error in the output file.
#
# Expected output: "which: no python3 in ($PATH)"
# ============================================================

#SBATCH -J ex7-no-module
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:01:00
#SBATCH -p work
#SBATCH --reservation=DeepNeuron # reservation
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

module purge
# Intentionally NOT loading Python

echo "=== PATH inside job (no modules loaded) ==="
echo $PATH | tr ':' '\n'

echo ""
echo "=== Attempting to find python3 ==="
which python3       # this will fail

echo ""
echo "=== Attempting to run python3 ==="
python3 --version   # this will also fail
