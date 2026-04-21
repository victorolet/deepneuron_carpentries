#!/bin/bash
# ============================================================
# Exercise 3 Part A — Basic job submission
#
# Tasks:
#   1. Review this script
#   2. Submit:  sbatch exercise3a_submit.sh
#   3. Monitor: squeue -u $USER
#   4. Read output: cat slurm-JOBID.out
#
# Question: what hostname appears in the output?
#           Is it the login node or a compute node?
# ============================================================

#SBATCH -J ex3a               # job name
#SBATCH -N 1                  # 1 node
#SBATCH -n 1                  # 1 task
#SBATCH -t 00:02:00           # 2-minute walltime
#SBATCH -p work               # partition
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "Job ID: $SLURM_JOB_ID"
echo "Submitted from: $SLURM_SUBMIT_DIR"

sleep 30    # sleep long enough to observe in squeue

echo "Job finished at: $(date)"
