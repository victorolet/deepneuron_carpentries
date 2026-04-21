#!/bin/bash
# ============================================================
# Exercise 7 — Modules in a Job Script
#
# Before submitting:
#   1. On the login node, find a Python module:
#        module avail Python
#   2. Replace the module name on the marked line below
#   3. Submit: sbatch exercise7_modules.sh
#   4. Read:   cat slurm-JOBID.out
#
# Questions:
#   - Is the path to python3 the same as on the login node?
#   - Run 'which python3' on the login node and compare.
# ============================================================

#SBATCH -J ex7-modules
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:01:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

# Always start with a clean slate
module purge

# EDIT THIS LINE — replace with the full module name from 'module avail Python'
module load Python/3.11.3-GCCcore-12.3.0

# Show what is loaded
echo "=== Loaded modules ==="
module list

echo ""
echo "=== Python location and version ==="
which python3
python3 --version

echo ""
echo "=== PATH inside the job (one entry per line) ==="
echo $PATH | tr ':' '\n'
