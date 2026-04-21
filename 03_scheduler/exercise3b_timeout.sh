#!/bin/bash
# ============================================================
# Exercise 3 Part B — Deliberate timeout
#
# This job is designed to be killed by Slurm.
# Walltime is 1 minute but the job sleeps for 300 seconds.
#
# Tasks:
#   1. Submit:  sbatch exercise3b_timeout.sh
#   2. Watch:   squeue -u $USER
#   3. After it disappears from the queue, check the output:
#              cat slurm-JOBID.out
#
# Question: what error message appears at the end of the output?
# Expected: slurmstepd: error: *** JOB ... CANCELLED AT ...
#                              DUE TO TIME LIMIT ***
# ============================================================

#SBATCH -J ex3b-timeout       # job name
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:01:00           # 1-minute walltime — intentionally too short
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "About to sleep for 300 seconds (walltime is only 60s)..."

sleep 300   # will be killed before this finishes

echo "This line will NOT be printed (job gets killed first)"
