# 02 — Exploring Remote Resources

## Key concepts

- Login nodes are **access points only** — never run heavy computation there
- Your home directory (`/home/username`) is **shared across all nodes**
- The cluster has different node types: login, compute, high-memory, GPU, storage
- Filesystems like `/home` and `/scratch` are visible on **every node simultaneously**

---

## Exercise 2: Explore the Cluster (8 min)

Run each command and note the output. Compare with your laptop where indicated.

```bash
# 1. How many CPU cores does the login node have?
nproc --all

# 2. How much RAM?
free -m          # output in megabytes
free -hw         # human-readable, wide format

# 3. What filesystems are mounted and what type are they?
df -Th
# Look at the 'Type' column: NFS / Lustre / GPFS = shared network filesystems

# 4. How many compute nodes are available in each partition?
sinfo

# 5. Find the node with the most CPUs
sinfo -o "%n %c %m"
# n=node name, c=CPU count, m=memory (MB)

# 6. Detailed CPU architecture
lscpu
```

### Discussion

- How do the CPU and RAM numbers compare to your laptop?
- Which filesystems are network-mounted (shared) vs. local?
- Note the node with the most CPUs — what partition is it in?

---

## Key commands reference

See `commands.sh` in this folder for all section commands.
