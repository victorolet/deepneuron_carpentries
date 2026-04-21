#!/bin/bash
# ============================================================
# Quick Command Reference — Introduction to HPC Workshop
# All key commands from every section in one place
# ============================================================

# ============================================================
# SECTION 01: Connecting (run on LOCAL machine)
# ============================================================
ls ~/.ssh/                                          # check for existing keys
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519  # generate Ed25519 key pair
eval $(ssh-agent)                                   # start SSH agent
ssh-add -t 8h ~/.ssh/id_ed25519                    # add key (8-hour expiry)
ssh couxxx@setonix.pawsey.org.au                    # connect to cluster

# ============================================================
# SECTION 02: Exploring (run on CLUSTER)
# ============================================================
hostname && pwd && whoami         # orient yourself
nproc --all                       # CPU count
free -hw                          # RAM (human-readable)
df -Th                            # filesystems and types
lscpu                             # CPU architecture
sinfo                             # cluster partitions and nodes
sinfo -o "%n %c %m"              # per-node CPU and memory
ls -lha ~                         # home directory with hidden files
cp ~/.bashrc ~/.bashrc.bak        # ALWAYS back up before editing

# ============================================================
# SECTION 03: Scheduler (run on CLUSTER)
# ============================================================
sbatch myscript.sh                # submit a job
squeue -u $USER                   # monitor your jobs
squeue -j JOBID -o "%R"          # why is job pending?
scancel JOBID                     # cancel one job
scancel -u $USER                  # cancel all your jobs
scontrol show job JOBID           # full job details
srun --pty bash                   # interactive compute node shell
scontrol hold JOBID               # pause queued job
scontrol release JOBID            # release held job

# ============================================================
# SECTION 04: Environment Variables (run on CLUSTER)
# ============================================================
echo $PATH | tr ':' '\n'         # PATH, one directory per line
export PATH=${PATH}:~/.local/bin  # extend PATH safely
env | grep SLURM                  # all Slurm variables (inside jobs)

# ============================================================
# SECTION 05: File Transfer
# ============================================================
# On the cluster:
wget https://example.com/data.tar.gz
curl -L -o file.tar.gz https://github.com/user/repo/tarball/main
tar -cvzf archive.tar.gz folder/     # create archive
tar -tf  archive.tar.gz              # list contents
tar -xvzf archive.tar.gz            # extract
du -sh folder/ archive.tar.gz       # compare sizes

# On your laptop:
rsync -avPn archive.tar.gz couxxx@setonix.pawsey.org.au:~/  # dry run first
rsync -avP  archive.tar.gz couxxx@setonix.pawsey.org.au:~/  # upload
rsync -avP  couxxx@setonix.pawsey.org.au:~/results/ ./results/  # download

# Object storage (on cluster):
rclone lsd acacia:
rclone copy results/ acacia:mybucket/results/ --transfers 16 -P

# ============================================================
# SECTION 06: Modules (run on CLUSTER)
# ============================================================
module avail                      # all available modules
module avail Python               # filter
module spider Python              # deep search (Lmod)
module list                       # currently loaded
module load Python                # load default
module load Python/3.11.3-GCCcore-12.3.0  # specific version (use in scripts)
module purge                      # remove ALL (use at start of job scripts)
which python3                     # confirm path after loading

# ============================================================
# SECTION 07: Parallel Jobs (run on CLUSTER)
# ============================================================
# Install Amdahl
cd ~/amdahl && module purge && module load Python
python3 -m pip install --user .
export PATH=${PATH}:~/.local/bin
amdahl --help

# Serial run
amdahl

# Parallel run
mpiexec amdahl

# CSV timing output (append to file)
mpiexec amdahl -t >> timing.csv

# Amdahl's Law: max speedup = 1 / (1 - p)
# p=0.85 -> 6.7x,  p=0.95 -> 20x,  p=0.99 -> 100x

# ============================================================
# SECTION 08: Resource Management (run on CLUSTER)
# ============================================================
sacct -u $USER                    # job history
sacct -u $USER --format=JobID,JobName,Elapsed,MaxRSS,AllocCPUS,State,ExitCode
sacct -l -j JOBID                 # full record for one job

# Calibration:
# new walltime = actual Elapsed × 1.25
# new memory   = actual MaxRSS (GB) × 1.25

# Login node monitoring:
top                               # live CPU + memory
ps ux                             # your processes
kill PID                          # terminate a process
