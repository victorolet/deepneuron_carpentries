# 07 — Running a Parallel Job

## Key concepts

- **OpenMP** (shared memory): multiple threads share one pool of RAM; limited to one node; use `-c N`
- **MPI** (distributed memory): multiple processes each with their own memory; can span nodes; use `-n N`; launch with `mpiexec`
- `mpiexec` inside a Slurm job reads `$SLURM_NTASKS` automatically — no need to pass `-n` explicitly
- **Amdahl's Law**: if fraction `p` of a program is parallel, max speedup = `1 / (1 - p)`
- Always measure efficiency = speedup / N × 100%; below 50% means more than half each CPU's time is wasted

---

## Setup: Install the Amdahl program

After completing Exercise 6 (file transfer), you should have an `amdahl/` directory.

```bash
cd ~/amdahl
module purge
module load Python
python3 -m pip install --user .
```

If `amdahl` is not found after installation:

```bash
# Add user local bin to PATH (add to ~/.bashrc to make permanent)
export PATH=${PATH}:~/.local/bin
echo 'export PATH=${PATH}:~/.local/bin' >> ~/.bashrc

# Confirm it works
amdahl --help
```

---

## Exercise 8: Scaling Study (20 min)

Submit the Amdahl program at four different core counts and record the timing.

```bash
# Edit the core count in exercise8_scaling.sh for each run,
# OR submit all four at once using the loop:
for N in 1 2 4 8; do
    sed "s/NCORES/$N/" exercise8_scaling_template.sh | sbatch
done
```

For each run, note the **Total execution time** from the output file.

Then calculate:

| CPUs (n) | Time (s) | Speedup S = t₁/tₙ | Ideal speedup | Efficiency E = S/n × 100% |
|----------|----------|-------------------|---------------|--------------------------|
| 1 | | 1.0× | 1× | 100% |
| 2 | | | 2× | |
| 4 | | | 4× | |
| 8 | | | 8× | |

### Discussion questions

1. At what core count do additional CPUs give diminishing returns?
2. Given p = 0.85, what is the theoretical maximum speedup from Amdahl's Law? `1 / (1 - 0.85) = 6.7×`
3. Rerun with `amdahl -p 0.95` — does the scaling improve?
4. At what core count does efficiency drop below 50%?

---

## Exercise 9: Parallel Scaling with CSV Output (10 min)

Automate the scaling study using a job array:

```bash
sbatch exercise9_array.sh
```

This submits 4 jobs (1, 2, 4, 8 CPUs) simultaneously. After all complete:

```bash
cat timing.csv
```

**Bonus** — display the CSV nicely:

```bash
python3 -c "import csv,sys; [print(r) for r in csv.reader(sys.stdin)]" < timing.csv
```

---

## Amdahl's Law — quick reference

```
S(n) = 1 / [ (1 - p) + p/n ]

S_max = 1 / (1 - p)   (as n → ∞)

p = 0.85 → S_max ≈ 6.7×
p = 0.95 → S_max = 20×
p = 0.99 → S_max = 100×
```
