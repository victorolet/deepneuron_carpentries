#!/bin/bash
# ============================================================
# Exercise 5 — Variables in a Job Script
#
# Tasks:
#   1. Review this script
#   2. Submit:  sbatch exercise5_vars.sh
#   3. Read:    cat slurm-JOBID.out
#
# Observe:
#   - Does $SLURM_SUBMIT_DIR match where you submitted from?
#   - Is $PATH shorter than on the login node?
#   - How many SLURM_* variables exist?
# ============================================================

#SBATCH -J ex5-vars
#SBATCH -N 1
#SBATCH -n 2                  # request 2 tasks to make SLURM_NTASKS interesting
#SBATCH -t 00:01:00
#SBATCH -p work
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err

# Step 1: change to submit directory (good practice in all job scripts)
cd $SLURM_SUBMIT_DIR

echo "============================================"
echo "Slurm job information"
echo "============================================"
echo "Job ID:           $SLURM_JOB_ID"
echo "Job name:         $SLURM_JOB_NAME"
echo "Tasks requested:  $SLURM_NTASKS"
echo "CPUs per task:    $SLURM_CPUS_PER_TASK"
echo "Memory (MB):      $SLURM_MEM_PER_NODE"
echo "Node(s):          $SLURM_NODELIST"
echo "Submit dir:       $SLURM_SUBMIT_DIR"
echo ""

echo "============================================"
echo "User environment"
echo "============================================"
echo "Hostname:         $(hostname)"
echo "User:             $USER"
echo "Home:             $HOME"
echo ""

# Custom variable
DATADIR=/scratch/pawseyXXXX/$USER    # update to your actual scratch path
echo "DATADIR:          $DATADIR"
echo ""

echo "============================================"
echo "PATH inside the job"
echo "============================================"
echo $PATH | tr ':' '\n'    # print each directory on its own line
echo ""

echo "============================================"
echo "All SLURM_* variables"
echo "============================================"
env | grep SLURM | sort
