#!/bin/bash
# ============================================================
# Section 01: Connecting to a Remote HPC System
# Key commands from the slides — run on your LOCAL machine
# ============================================================

# --- SSH key generation ---
ls ~/.ssh/                                    # check for existing keys
ssh-keygen -a 100 -t ed25519 -f ~/.ssh/id_ed25519   # generate Ed25519 pair

# --- SSH agent ---
eval $(ssh-agent)                             # start the agent
ssh-add -t 8h ~/.ssh/id_ed25519              # add key, expires after 8 hours
ssh-add -l                                   # list keys currently in agent

# --- Connect to cluster ---
ssh couxxx@setonix.pawsey.org.au             # basic login
ssh -v couxxx@setonix.pawsey.org.au          # verbose (useful for debugging)

# --- Once connected ---
hostname                                      # which machine am I on?
whoami                                        # what is my username?
exit                                          # disconnect

# --- Prompt conventions used in this workshop ---
# [you@laptop:~]$         = running locally on your machine
# [couxxx@login1 ~]$      = running on the cluster login node
# $                       = works in either environment
