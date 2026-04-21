# 04 — Environment Variables

## Key concepts

- A **shell variable** (`NAME=value`) is local to the current shell — child processes cannot see it
- An **environment variable** (`export NAME=value`) is inherited by child processes, including job scripts
- `$PATH` is a colon-separated list of directories bash searches for programs — **always extend it, never replace it**
- Slurm automatically sets `$SLURM_*` variables inside every job

---

## Important built-in variables

| Variable | Meaning |
|----------|---------|
| `$HOME` | Your home directory |
| `$USER` | Your username |
| `$PATH` | Executable search path |
| `$PWD` | Current working directory |
| `$HOSTNAME` | Machine name |

## Slurm variables (set automatically inside jobs)

| Variable | Meaning |
|----------|---------|
| `$SLURM_SUBMIT_DIR` | Directory where `sbatch` was called |
| `$SLURM_JOB_ID` | The job ID number |
| `$SLURM_NTASKS` | Number of tasks allocated |
| `$SLURM_CPUS_PER_TASK` | CPUs per task (`-c` value) |
| `$SLURM_MEM_PER_NODE` | Memory in MB |
| `$SLURM_NODELIST` | Which nodes the job is on |
| `$SLURM_ARRAY_TASK_ID` | Array index (job arrays only) |

---

## Exercise 5: Variables in a Job Script (10 min)

Use `exercise5_vars.sh`. Review it, then submit:

```bash
cat exercise5_vars.sh
sbatch exercise5_vars.sh
cat slurm-JOBID.out
```

**Things to observe in the output:**

1. Is `$SLURM_SUBMIT_DIR` the directory you submitted from?
2. Does `$SLURM_JOB_ID` match the job number Slurm reported?
3. Is `$PATH` inside the job shorter than on the login node?
   (Run `echo $PATH` on the login node to compare)
4. How many `SLURM_*` variables does `env | grep SLURM` show?

---

## PATH safety rule

```bash
# SAFE — extends PATH without losing existing entries
export PATH=~/.local/bin:$PATH

# DANGEROUS — replaces PATH entirely, breaks ls, cp, python3, etc.
export PATH=~/.local/bin        # DO NOT DO THIS
```
