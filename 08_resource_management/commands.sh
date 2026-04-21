#!/bin/bash
# ============================================================
# Section 08: Using Resources Effectively
# Run on the CLUSTER
# ============================================================

# --- Basic job history ---
sacct -u $USER                          # summary of recent jobs

# --- Calibration query: key fields for right-sizing ---
sacct -u $USER \
  --format=JobID,JobName,Elapsed,MaxRSS,AllocCPUS,State,ExitCode

# --- Full record for one specific job ---
sacct -l -j JOBID | less -S            # press q to quit

# --- Calibration query: compare requested vs used ---
sacct -u $USER \
  --format=JobID,Timelimit,Elapsed,ReqMem,MaxRSS,State

# --- Find failed or timed-out jobs ---
sacct -u $USER --format=JobID,JobName,State,ExitCode | grep -v COMPLETED

# --- Live resource usage (while a job is running) ---
sstat -j JOBID
sstat -j JOBID --format=JobID,MaxRSS,AveCPU,NTasks

# --- Useful calculations ---
# MaxRSS is reported in KB
# Convert KB to GB: divide by 1,048,576
# New walltime request:   actual_elapsed × 1.25
# New memory request:     actual_MaxRSS_GB × 1.25  (rounded up)

# --- Login node monitoring ---
top                     # live CPU and memory usage (press q to quit)
ps ux                   # your processes
kill PID                # terminate a specific process
