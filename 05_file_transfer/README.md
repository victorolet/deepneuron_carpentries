# 05 — Transferring Files

## Key concepts

- `wget` / `curl` download from the internet directly to the cluster (may be blocked by firewall)
- `tar` archives many files into one — always archive before transferring large numbers of files
- `scp` is simple; `rsync` is better for large, resumable, or repeated transfers
- `rclone` is the tool for TB-scale transfers to/from object storage (Pawsey Acacia, AWS S3)
- **Always test** with `rsync -n` (dry run) before the real transfer

---

## Exercise 6: Upload, Archive, and Transfer (20 min)

### On your laptop

```bash
# Download the Amdahl tarball
curl -L -o amdahl.tar.gz \
  https://github.com/hpc-carpentry/amdahl/tarball/main

# Dry-run first to confirm what will be transferred
rsync -avPn amdahl.tar.gz couxxx@setonix.pawsey.org.au:~/

# Upload to the cluster
rsync -avP amdahl.tar.gz couxxx@setonix.pawsey.org.au:~/
```

### On the cluster

```bash
# Check what's in the archive before extracting
tar -tf amdahl.tar.gz

# Extract
tar -xvzf amdahl.tar.gz

# The extracted folder has a long auto-generated name — rename it
mv hpc-carpentry-amdahl-*/  amdahl/

# Compare compressed vs uncompressed size
du -sh amdahl/ amdahl.tar.gz

# Create a new backup archive
tar -cvzf my-backup.tar.gz amdahl/
```

### Download back to laptop (run on your laptop)

```bash
# Dry run first
rsync -avPn couxxx@setonix.pawsey.org.au:~/my-backup.tar.gz ./

# Real transfer
rsync -avP couxxx@setonix.pawsey.org.au:~/my-backup.tar.gz ./
```

---

## tar flag reference

| Flag | Meaning |
|------|---------|
| `-c` | Create archive |
| `-x` | Extract archive |
| `-t` | List contents (without extracting) |
| `-v` | Verbose (show filenames as processed) |
| `-z` | Compress/decompress with gzip |
| `-f` | Filename follows (must be last flag before filename) |

## rsync flag reference

| Flag | Meaning |
|------|---------|
| `-a` | Archive mode (preserves timestamps, permissions, symlinks) |
| `-v` | Verbose |
| `-P` | Progress display + resume partial transfers |
| `-z` | Compress during transfer (useful on slow links) |
| `-n` | Dry run — shows what would transfer, does nothing |

---

## Key commands reference

See `commands.sh` in this folder.
