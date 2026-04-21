#!/bin/bash
# ============================================================
# Section 04: Environment Variables
# Key commands — run on the CLUSTER login node
# ============================================================

# --- Shell vs environment variables ---
NAME=Alice                      # shell variable (local only)
echo "$NAME"                    # prints: Alice

export NAME=Alice               # environment variable (inherited by children)
export SCRATCH=/scratch/pawseyXXXX/$USER

# --- View variables ---
set                             # ALL shell variables (very long)
env                             # only exported (environment) variables
echo $HOME                      # one specific variable
echo $PATH                      # the executable search path

# --- PATH management ---
echo $PATH                      # view current PATH
mkdir -p ~/.local/bin           # create user bin directory

# Safe extension — ALWAYS keep :$PATH at the end
export PATH=~/.local/bin:$PATH

# Verify
echo $PATH

# --- Important Slurm variables (run inside a job to see values) ---
# echo $SLURM_SUBMIT_DIR
# echo $SLURM_JOB_ID
# echo $SLURM_NTASKS
# echo $SLURM_CPUS_PER_TASK
# echo $SLURM_MEM_PER_NODE
# echo $SLURM_NODELIST
# env | grep SLURM              # dump all SLURM_* variables at once
