# Slurm Quick Reference

## Job submission and control

```bash
sbatch script.sh                       # submit a job
squeue -u $USER                        # my jobs only
squeue                                 # all jobs on the system
squeue -j JOBID                        # one specific job
squeue -j JOBID -o "%R"               # why is this job pending?
squeue --start -j JOBID               # estimated start time

scancel JOBID                          # cancel one job
scancel -u $USER                       # cancel ALL my jobs

scontrol show job JOBID                # full job record
scontrol hold JOBID                    # pause a queued job
scontrol release JOBID                 # resume a held job

srun hostname                          # run one command on compute node
srun --pty bash                        # interactive shell on compute node
srun -n 4 --mem=8g --pty bash          # interactive with resources

sstat -j JOBID                         # live resource usage (running jobs)
```

## Job history and accounting

```bash
sacct -u $USER                                              # recent jobs
sacct -u $USER --format=JobID,JobName,Elapsed,MaxRSS,AllocCPUS,State,ExitCode
sacct -l -j JOBID                                           # full record
sacct -l -j JOBID --format=JobID,MaxRSS,Elapsed,ReqMem,CPUTime,State
```

## Cluster information

```bash
sinfo                                  # partition and node status
sinfo -p work                          # one partition
sinfo -o "%P %l %D %c"                 # partition time limits and CPU counts
sinfo -o "%n %c %m"                    # per-node CPU and memory
sinfo -o "%n %G"                       # GPU nodes
```

---

## Common `#SBATCH` directives

```bash
#SBATCH -J jobname                     # job name
#SBATCH -N 2                           # number of nodes
#SBATCH -n 8                           # number of tasks (MPI processes)
#SBATCH -c 4                           # CPUs per task (OpenMP threads)
#SBATCH --mem=16g                      # total memory per node
#SBATCH --mem-per-cpu=2g               # memory per CPU
#SBATCH -t 02:00:00                    # walltime HH:MM:SS
#SBATCH -p work                        # partition
#SBATCH -o output-%j.txt               # stdout (%j = job ID)
#SBATCH -e error-%j.txt                # stderr
#SBATCH --mail-type=END,FAIL           # email notification
#SBATCH --mail-user=you@inst.edu       # email address
#SBATCH --array=1-100                  # job array
#SBATCH --array=1-100%5                # job array, max 5 running at once
```

---

## Job states

| State | Meaning |
|-------|---------|
| `PD` | Pending — waiting in queue |
| `R` | Running |
| `CG` | Completing |
| `CD` | Completed successfully |
| `F` | Failed (non-zero exit code) |
| `TO` | Timed Out (exceeded walltime) |
| `OOM` | Out of Memory (exceeded `--mem`) |
| `CA` | Cancelled |

## Pending reasons

| Reason | Meaning |
|--------|---------|
| `Resources` | No free nodes right now |
| `Priority` | Higher-priority jobs ahead |
| `QOSMaxJobsPerUser` | Hit per-user job limit |

---

## Slurm variables (inside job scripts)

```bash
$SLURM_SUBMIT_DIR      # where sbatch was called from
$SLURM_JOB_ID          # the job ID number
$SLURM_JOB_NAME        # job name
$SLURM_NTASKS          # number of tasks allocated
$SLURM_CPUS_PER_TASK   # CPUs per task
$SLURM_MEM_PER_NODE    # memory in MB
$SLURM_NODELIST        # nodes the job is running on
$SLURM_ARRAY_TASK_ID   # array index (job arrays only)

env | grep SLURM        # print all SLURM_* variables
```

---

## Parallelism flags

| Goal | Directives | Launch |
|------|-----------|--------|
| Serial | `-N 1 -n 1` | `./program` |
| OpenMP (8 threads) | `-N 1 -n 1 -c 8` + `export OMP_NUM_THREADS=8` | `./program` |
| MPI (8 processes, 1 node) | `-N 1 -n 8` | `mpiexec ./program` |
| MPI (8 processes, 2 nodes) | `-N 2 -n 8` | `mpiexec ./program` |
| Hybrid (2 MPI × 16 threads) | `-N 2 -n 2 -c 16` + `export OMP_NUM_THREADS=16` | `mpiexec ./program` |
