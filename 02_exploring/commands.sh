#!/bin/bash
# ============================================================
# Section 02: Exploring Remote Resources
# Run these on the CLUSTER after logging in
# ============================================================

# --- Orient yourself after login ---
hostname                    # which login node am I on?
pwd                         # current directory
ls                          # list contents
ls -lh                      # long format, human-readable sizes
ls -a                       # include hidden files (start with .)
ls -lha                     # all of the above combined

# --- Inspect the login node hardware ---
nproc --all                 # total CPU threads
free -hw                    # RAM (human-readable, wide format)
free -m                     # RAM in megabytes
df -Th                      # filesystems, types, and usage
lscpu                       # CPU architecture details

# --- Explore the cluster layout ---
sinfo                                  # all partitions and node states
sinfo -p work                          # one specific partition
sinfo -o "%P %.5a %.10l %.6D %.6t %N"  # detailed partition summary
sinfo -o "%n %c %m"                    # per-node CPU and memory
sinfo -o "%n %G"                       # GPU nodes (shows GPU type)

# --- Home directory hidden files ---
ls -a ~                     # show hidden files in home
cat ~/.bashrc               # view your bash configuration
# ALWAYS back up before editing:
cp ~/.bashrc ~/.bashrc.bak

# --- Understand shared filesystems ---
# NFS / Lustre / GPFS in df -Th output = shared across all nodes
# /tmp = local to each node, fast, deleted when job ends
