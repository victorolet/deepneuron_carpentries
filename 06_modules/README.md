# 06 — Software Modules

## Key concepts

- A single cluster serves hundreds of users needing different (often conflicting) software versions
- Modules adjust `PATH`, `LD_LIBRARY_PATH`, and other variables when loaded — and reverse those changes when unloaded
- **Always `module purge` before loading anything in a job script** — ensures a clean, reproducible environment
- Modules loaded interactively on the login node are **not** automatically available on compute nodes

---

## Essential module commands

```bash
module avail                      # list all available modules
module avail Python               # filter by name
module spider Python              # deep search including dependencies (Lmod only)
module list                       # show currently loaded modules
module load Python                # load default version
module load python/3.11.6   # load specific version (use in scripts)
which python3                     # confirm path changed
module unload Python              # remove one module
module purge                      # remove ALL loaded modules
```

## In a job script — always use this pattern

```bash
module purge                              # start from a clean slate
module load Python/3.11.3-GCCcore-12.3.0  # specific version for reproducibility
module load SciPy-bundle                   # add dependencies as needed
module list                               # useful for debugging: shows everything loaded
```

---

## Exercise 7: Modules in a Job Script (8 min)

### Step 1 — Find a Python module on the login node

```bash
module avail Python
module spider Python      # Lmod only — shows all versions including hidden ones
```

Note the full module name (e.g. `Python/3.11.3-GCCcore-12.3.0`).

### Step 2 — Submit the exercise script

Edit `exercise7_modules.sh` to use the Python module name you found, then submit:

```bash
# Edit the module name on the marked line
nano exercise7_modules.sh   # or vim, gedit, etc.

sbatch exercise7_modules.sh
cat slurm-JOBID.out
```

**Key question:** Is the path to `python3` the same as on the login node?

### Step 3 — Bonus: submit without loading Python

Edit `exercise7_no_module.sh` (does not load Python) and submit it:

```bash
sbatch exercise7_no_module.sh
cat slurm-JOBID.out
```

**Expected:** `which: no python3 in ($PATH)` — the compute node default PATH is minimal.

---

## Why `module purge` matters

When Slurm starts a job, it may inherit some of your interactive login environment.
If you loaded `Python/3.9` interactively but need `Python/3.11` in the job, and you
don't purge first, the wrong version might be used — or module conflicts can cause
silent failures.

`module purge` guarantees a clean slate every time.
