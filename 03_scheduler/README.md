# 03 — Scheduler Fundamentals (Slurm)

## Key concepts

- Slurm manages who gets which nodes, when jobs start, and how much they get
- A job script is a bash script with `#SBATCH` resource directives in the header
- `#SBATCH` lines look like comments to bash but are read by Slurm before the job starts
- Resource limits are **enforced absolutely** — exceeding walltime or memory kills your job

---

## Job script anatomy

Every Slurm job script has three parts:

```bash
#!/bin/bash                    # 1. Shebang — interpreter

#SBATCH -J my-job              # 2. SBATCH directives — resource requests
#SBATCH -N 1                   #    (read by Slurm; ignored if script run directly)
#SBATCH -n 1
#SBATCH --mem=4g
#SBATCH -t 00:30:00
#SBATCH -p work
#SBATCH -o output-%j.txt       #    %j is replaced by the job ID

module purge                   # 3. Job commands — the actual work
module load Python
python my_script.py
```

---

## Common `#SBATCH` directives

| Directive | Meaning |
|-----------|---------|
| `-J name` | Job name (shown in queue) |
| `-N N` | Number of nodes |
| `-n N` | Number of tasks (≈ CPU cores) |
| `-c N` | CPUs per task (for threaded/OpenMP jobs) |
| `--mem=Xg` | Total memory per node |
| `--mem-per-cpu=Xg` | Memory per CPU |
| `-t HH:MM:SS` | Walltime limit |
| `-p partition` | Partition/queue name |
| `-o file.%j` | Stdout file (`%j` = job ID) |
| `-e file.%j` | Stderr file |
| `--mail-type=END,FAIL` | Email on finish or failure |
| `--mail-user=you@inst.edu` | Email address |

---

## Exercise 3: Submit and Monitor a Job (15 min)

### Part A — Basic submission

Use the script `exercise3a_submit.sh`. Review it, then submit:

```bash
cat exercise3a_submit.sh     # read the script first
sbatch exercise3a_submit.sh  # submit it
```

Then:
```bash
squeue -u $USER              # watch your job (repeat until finished)
cat slurm-JOBID.out          # read the output (replace JOBID with your number)
```

**Key question:** What hostname appears in the output? Is it the login node?

### Part B — Deliberate timeout

Use `exercise3b_timeout.sh` (sleeps for 300s with a 1-minute walltime):

```bash
sbatch exercise3b_timeout.sh
squeue -u $USER              # watch it get killed
cat slurm-JOBID.out          # find the timeout error message
```

**Expected error:** `slurmstepd: error: *** JOB ... CANCELLED AT ... DUE TO TIME LIMIT ***`

### Part C — Email notification

Edit `exercise3a_submit.sh` and add to the `#SBATCH` block:
```bash
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=your@email.com
```

---

## Managing jobs

```bash
scancel JOBID                # cancel one job
scancel -u $USER             # cancel all your jobs
scontrol show job JOBID      # full details of a job
sstat -j JOBID               # live resource usage (running jobs only)
squeue -j JOBID -o "%R"      # why is this job pending?
```

### Pending reasons

| Reason | Meaning |
|--------|---------|
| `Resources` | No free nodes right now |
| `Priority` | Higher-priority jobs ahead |
| `QOSMaxJobsPerUser` | Hit per-user job limit |

### Interactive sessions

```bash
srun hostname                        # run one command on a compute node
srun --pty bash                      # interactive shell on a compute node
srun -n 4 --mem=8g --pty bash        # with specific resources

scontrol hold JOBID                  # pause a queued job
scontrol release JOBID               # resume it
```
