# Introduction to HPC — Workshop Materials

**Pawsey Supercomputing Research Centre**  
Based on the [HPC Carpentries](https://hpc-carpentry.org) curriculum (CC-BY 4.0)

---

## How to use this repository

After logging into the cluster, clone this repository to your home directory:

```bash
git clone https://github.com/YOUR-ORG/hpc-workshop.git
cd hpc-workshop
```

Each numbered folder corresponds to a section of the workshop. Inside you will find:

- `README.md` — section overview and exercise instructions
- `commands.sh` — all key commands from the slides, ready to copy/paste or run
- Job scripts and solution scripts where applicable

---

## Workshop sections

| Folder | Section |
|--------|---------|
| `00_setup/` | Pre-workshop setup checklist |
| `01_connecting/` | SSH, key pairs, SSH agent |
| `02_exploring/` | Exploring the cluster |
| `03_scheduler/` | Slurm — submitting and managing jobs |
| `04_environment_variables/` | Shell and environment variables |
| `05_file_transfer/` | wget, tar, scp, rsync, rclone |
| `06_modules/` | Environment modules |
| `07_parallel_jobs/` | Parallel computing and Amdahl's Law |
| `08_resource_management/` | sacct, resource calibration |
| `reference/` | Cheat sheets and quick-reference commands |

---

## Cluster details (fill in before the workshop)

| Item | Value |
|------|-------|
| Login hostname | `setonix.pawsey.org.au` |
| Your username | `couxxx` (provided by instructor) |
| Default partition | `work` |
| Scratch filesystem | `/scratch/pawsey XXXX/couxxx` |

---

## License

Materials based on *Introduction to HPC* by HPC Carpentries, licensed CC-BY 4.0.
