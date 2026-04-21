#!/bin/bash
# ============================================================
# Section 03: Scheduler Fundamentals
# Key commands — run on the CLUSTER
# ============================================================

# --- Explore partitions ---
sinfo                                   # all partitions summary
sinfo -p work                           # one specific partition
sinfo -o "%P %l %D %c"                  # partition name, time limit, nodes, CPUs

# --- Submit and monitor ---
sbatch myscript.sh                      # submit a job script
squeue -u $USER                         # your jobs only
squeue                                  # all jobs on the system
squeue -j JOBID                         # one specific job
squeue -j JOBID -o "%R"                 # why is this job pending?
squeue --start -j JOBID                 # estimated start time

# --- Job output ---
cat slurm-JOBID.out                     # default output file
ls slurm-*.out                          # list all output files

# --- Cancel and inspect ---
scancel JOBID                           # cancel one job
scancel -u $USER                        # cancel ALL your jobs
scontrol show job JOBID                 # full job details
sstat -j JOBID                          # live resource usage (while running)

# --- Interactive sessions ---
srun hostname                           # run one command on compute node
srun --pty bash                         # interactive shell on compute node
srun -n 4 --mem=8g --pty bash           # interactive with specific resources

# --- Hold / release ---
scontrol hold JOBID                     # pause a queued job
scontrol release JOBID                  # release it back to queue

# --- Job history ---
sacct -u $USER                          # recent job history
sacct -u $USER --format=JobID,JobName,Elapsed,MaxRSS,AllocCPUS,State,ExitCode
sacct -l -j JOBID                       # full record for one job
