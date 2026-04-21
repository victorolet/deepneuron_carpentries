#!/bin/bash
# ============================================================
# timing.sh — Collect CSV timing data from Amdahl
#
# Used in the "Parallel Job: Output and Timing Flags" slides.
# Run this at different -n values and all results accumulate
# in timing.csv.
#
# Submit: sbatch timing.sh
# Review: cat timing.csv
# ============================================================

#SBATCH -J amdahl-timing
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

module purge
module load Python
module load SciPy-bundle

# -t flag outputs CSV data: CPUs, time, speedup
# >> appends to file so multiple runs accumulate
mpiexec amdahl -t >> timing.csv

echo "Appended result to timing.csv"
cat timing.csv
