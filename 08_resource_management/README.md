# 08 — Using Resources Effectively

## Key concepts

- `sacct` reports what your completed jobs **actually** used (CPU time, RAM, walltime, exit status)
- Comparing **requested** vs **used** resources is the calibration mechanism for efficient job submission
- Over-requesting harms everyone: your job waits longer for a large slot; other users queue behind you; CPUs and RAM sit idle
- A **20–30% buffer** above observed usage is appropriate — not 2× or 10×
- Always run a small test before scaling to production

---

## `sacct` field reference

| Field | Meaning |
|-------|---------|
| `Elapsed` | Actual wall time used — compare to `-t` |
| `MaxRSS` | Peak RAM in KB — divide by 1,048,576 for GB |
| `AllocCPUS` | CPUs allocated |
| `CPUTime` | AllocCPUS × Elapsed = total CPU-time consumed |
| `State` | COMPLETED / FAILED / TIMEOUT / OUT_OF_MEMORY |
| `ExitCode` | `0:0` = success; non-zero = program error |
| `Timelimit` | Walltime you requested |
| `ReqMem` | Memory you requested |

---

## Exercise 10: Review and Refine Resources (10 min)

```bash
# 1. See all your jobs from today
sacct -u $USER

# 2. Check a specific job in detail (replace JOBID)
sacct -l -j JOBID --format=JobID,MaxRSS,Elapsed,ReqMem,CPUTime,State,ExitCode

# 3. Compare requested vs used
#    - Elapsed vs your -t (walltime)
#    - MaxRSS vs your --mem
```

**Action:** Update your parallel Amdahl job script with calibrated values:
- New walltime = actual elapsed × 1.25
- New memory = actual MaxRSS (in GB, rounded up) × 1.25

Then resubmit and confirm it still completes successfully.

**Bonus:**
```bash
# Look for any FAILED or TIMEOUT jobs
sacct -u $USER --format=JobID,JobName,State,ExitCode | grep -v COMPLETED

# For each failed job, check the output file for the error
cat slurm-JOBID.out
```

---

## Calibration workflow (use for any new job type)

```
1. Submit small test with generous resources
         ↓
2. sacct -l -j JOBID  →  note Elapsed and MaxRSS
         ↓
3. New request = actual × 1.25
         ↓
4. Update #SBATCH directives
         ↓
5. Repeat until estimates are stable
```

---

## Key commands reference

See `commands.sh` in this folder.
