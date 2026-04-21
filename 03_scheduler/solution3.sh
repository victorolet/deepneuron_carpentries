#!/bin/bash
# ============================================================
# Solution: Exercise 3 — Complete working job script
#
# Includes:
#   - Correct resource requests
#   - Email notification (Part C) — update your email address
#   - Output and error files using %j (job ID)
# ============================================================

#SBATCH -J hello-solution
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err
#SBATCH --mail-type=END,FAIL               # Part C: email on finish or failure
#SBATCH --mail-user=your@email.com         # Part C: replace with your address

echo "Running on: $(hostname)"
date
sleep 30
echo "Finished."
