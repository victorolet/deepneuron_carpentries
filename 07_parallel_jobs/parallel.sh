#!/bin/bash
# ============================================================
# parallel.sh — Run Amdahl with 4 MPI tasks
#
# Submit:  sbatch parallel.sh
# Compare the execution time to serial.sh.
# Expected: ~2.75x faster (not 4x — Amdahl's Law explains why)
# ============================================================

#SBATCH -J amdahl-parallel
#SBATCH -N 1
#SBATCH -n 4                  # 4 MPI tasks = 4 CPU cores
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

module purge
module load Python
module load SciPy-bundle      # provides mpi4py for parallel Amdahl

echo "=== Parallel Amdahl run ==="
echo "Node: $(hostname)"
echo "MPI tasks: $SLURM_NTASKS"
echo "Started: $(date)"
echo ""

# mpiexec reads $SLURM_NTASKS automatically inside a Slurm job
mpiexec amdahl

echo ""
echo "Finished: $(date)"
