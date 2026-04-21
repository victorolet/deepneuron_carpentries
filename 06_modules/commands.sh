#!/bin/bash
# ============================================================
# Section 06: Software Modules
# Run on the CLUSTER
# ============================================================

# --- Discovering modules ---
module avail                        # all available modules
module avail Python                 # filter by name
module avail R                      # another example
module spider Python                # deep search (Lmod only)

# --- Loading and inspecting ---
module list                         # what's currently loaded?
module load Python                  # load default version
which python3                       # confirm path changed
python3 --version                   # confirm version

module load Python/3.11.3-GCCcore-12.3.0   # load specific version (use in scripts!)

# Loading a complex module often auto-loads dependencies
module load GROMACS                 # example: pulls in OpenMPI, FFTW, etc.
module list                         # see everything that got loaded

# --- Unloading ---
module unload Python                # remove one module
module purge                        # remove ALL loaded modules (use this in scripts)
module list                         # confirm nothing is loaded

# --- Standard job script pattern ---
# module purge
# module load Python/3.11.3-GCCcore-12.3.0
# module load SciPy-bundle
# python3 my_script.py
