#!/bin/bash
# ============================================================
# Section 07: Running a Parallel Job
# Run on the CLUSTER
# ============================================================

# --- Install Amdahl (run once after file transfer exercise) ---
cd ~/amdahl
module purge
module load cray-python/3.11.7
module load libfabric/1.22.0
python3 -m pip install --user .

# Add ~/.local/bin to PATH if needed
export PATH=${PATH}:~/.local/bin
amdahl --help                               # confirm it works

# --- Amdahl program options ---
amdahl                                      # default: p=0.85, 30s work
amdahl -p 0.95                              # 95% parallel fraction
amdahl -w 60                                # 60 seconds of work
amdahl -t                                   # output CSV timing data (for Exercise 9)
amdahl -p 0.95 -w 60 -t                     # combine flags

# --- Check available modules for MPI ---
module avail SciPy-bundle                   # contains mpi4py (needed for parallel amdahl)
module avail OpenMPI

# --- Slurm: key resource flags for parallel jobs ---
# OpenMP (shared memory, one node):
#   #SBATCH -n 1
#   #SBATCH -c 8          <- CPUs per task
#   export OMP_NUM_THREADS=8

# MPI (distributed memory, can span nodes):
#   #SBATCH -N 1
#   #SBATCH -n 8          <- number of MPI tasks
#   mpiexec ./my_program  <- reads $SLURM_NTASKS automatically

# Hybrid MPI + OpenMP:
#   #SBATCH -N 2 -n 2 -c 16
#   export OMP_NUM_THREADS=16
#   mpiexec ./my_program

# --- Review timing output ---
cat timing.csv                              # after Exercise 9 completes
sort -t, -k1 -n timing.csv                 # sort by CPU count

# --- Interpreting 'time' command output ---
# real  = wall clock time (what you care about)
# user  = total CPU time across all processes (≈ n × real for n tasks)
# sys   = time in kernel operations

# python commands to read to screen
python3 -c "import csv,sys; [print(r) for r in csv.reader(sys.stdin)]" < timing.csv