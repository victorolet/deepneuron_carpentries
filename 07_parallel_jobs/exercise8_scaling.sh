#!/bin/bash
# ============================================================
# Exercise 8 — Scaling Study
#
# Run this script four times, changing -n each time:
#   sbatch --job-name=scale-1 -n 1 exercise8_scaling.sh
#   sbatch --job-name=scale-2 -n 2 exercise8_scaling.sh
#   sbatch --job-name=scale-4 -n 4 exercise8_scaling.sh
#   sbatch --job-name=scale-8 -n 8 exercise8_scaling.sh
#
# OR edit the -n line below and resubmit for each core count.
#
# After all four jobs finish, fill in the results table in
# the README.md for this section.
# ============================================================

#SBATCH -J amdahl-scale
#SBATCH -N 1
#SBATCH -n 4                  # <-- CHANGE THIS: try 1, 2, 4, 8
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH -o scale-n%t-%j.out   # %t = ntasks, %j = job ID
#SBATCH -e scale-n%t-%j.err

module purge
module load Python
module load SciPy-bundle

echo "=== Scaling study: $SLURM_NTASKS task(s) ==="
echo "Node: $(hostname)"
echo "Started: $(date)"
echo ""

if [ "$SLURM_NTASKS" -eq 1 ]; then
    # Serial run (no MPI)
    amdahl
else
    # Parallel run
    mpiexec amdahl
fi

echo ""
echo "Finished: $(date)"
