#!/bin/bash
# ============================================================
# hello.sh — Minimal example Slurm job script
# Submit with:  sbatch hello.sh
# Monitor with: squeue -u $USER
# Output:       slurm-JOBID.out (or check with: cat slurm-*.out)
# ============================================================

#SBATCH -J hello              # job name
#SBATCH -N 1                  # 1 node
#SBATCH -n 1                  # 1 task (1 CPU core)
#SBATCH -t 00:02:00           # 2-minute walltime limit
#SBATCH -p work               # partition (adjust to your system)
#SBATCH -o slurm-%j.out       # output file (%j = job ID)
#SBATCH -e slurm-%j.err       # error file

# ---- Job commands start here ----
echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "Working directory: $(pwd)"
echo "Job ID: $SLURM_JOB_ID"

sleep 10    # simulate a short piece of work

echo "Job finished at: $(date)"
