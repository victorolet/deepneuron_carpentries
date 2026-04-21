#!/bin/bash
# ============================================================
# Section 05: Transferring Files
# Commands marked LOCAL run on your laptop
# Commands marked CLUSTER run on the cluster
# ============================================================

# ---- Downloading to the cluster (CLUSTER) ----
wget https://example.com/data.tar.gz                      # save original filename
wget -O mydata.tar.gz https://example.com/data.tar.gz     # custom filename

curl -L -o amdahl.tar.gz \
  https://github.com/hpc-carpentry/amdahl/tarball/main    # follow redirects

# Verify the download
ls -lh amdahl.tar.gz           # check size (0 bytes = download failed)
file amdahl.tar.gz             # check actual file type

# ---- tar — archive before transferring (CLUSTER) ----
tar -cvzf archive.tar.gz folder/        # create compressed archive
tar -tf  archive.tar.gz                 # list contents (no extraction)
tar -xvzf archive.tar.gz               # extract
du -sh folder/ archive.tar.gz          # compare sizes

# Without compression (for already-compressed data like HDF5, NetCDF):
tar -cvf archive.tar folder/
tar -xvf archive.tar

# ---- scp — simple secure copy (LOCAL) ----
scp file.txt couxxx@setonix.pawsey.org.au:~/             # upload file
scp -r folder/ couxxx@setonix.pawsey.org.au:~/           # upload directory
scp couxxx@setonix.pawsey.org.au:~/results.tar.gz ./     # download file

# ---- rsync — resumable, incremental (LOCAL) ----
# Dry run first — always
rsync -avPn archive.tar.gz couxxx@setonix.pawsey.org.au:~/

# Real transfer
rsync -avP archive.tar.gz couxxx@setonix.pawsey.org.au:~/
rsync -avP results/ couxxx@setonix.pawsey.org.au:~/results/    # upload dir
rsync -avP couxxx@setonix.pawsey.org.au:~/results/ ./results/  # download dir

# With compression (useful on slow links)
rsync -avPz archive.tar.gz couxxx@setonix.pawsey.org.au:~/

# ---- rclone — object storage at scale (CLUSTER) ----
rclone config                                          # one-time setup
rclone lsd acacia:                                     # list buckets
rclone ls  acacia:mybucket/                            # list objects in bucket
rclone copy results/ acacia:mybucket/results/ -P       # upload with progress
rclone copy acacia:mybucket/results/ ./results/ -P     # download

# Parallel transfers (4-10x faster for many files)
rclone copy results/ acacia:mybucket/results/ --transfers 16 -P
