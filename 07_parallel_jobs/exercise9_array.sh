#!/bin/bash
# ============================================================
# Exercise 9 — Parallel Scaling with CSV Output (Job Array)
#
# Submits 4 jobs simultaneously with task IDs 1, 2, 4, 8.
# Each task uses its ID as the number of MPI tasks.
# All results are appended to timing.csv.
#
# Submit:  sbatch exercise9_array.sh
# After all finish: cat timing.csv
#
# Bonus: python3 -c "import csv,sys; [print(r) for r in csv.reader(sys.stdin)]" < timing.csv
# ============================================================

#SBATCH -J amdahl-array
#SBATCH -N 1
#SBATCH --array=1,2,4,8       # task IDs double as CPU counts
#SBATCH -n 8                  # maximum tasks needed (Slurm uses --array value as -n)
#SBATCH -t 00:02:00
#SBATCH -p work
#SBATCH --reservation=DeepNeuron # reservation
#SBATCH -o array-%A-%a.out    # %A = parent job ID, %a = array index
#SBATCH -e array-%A-%a.err

module purge
module load cray-python/3.11.7
module load py-scipy/1.14.1

# Use the array task ID as the number of MPI tasks
# This overrides Slurm's allocation; mpiexec uses -n explicitly here
N=$SLURM_ARRAY_TASK_ID

echo "=== Array task ID: $N (using $N MPI task(s)) ==="
echo "Node: $(hostname)"

if [ "$N" -eq 1 ]; then
    amdahl -t >> timing.csv       # serial, append CSV row
else
    srun -n $N amdahl -t >> timing.csv   # parallel, append CSV row
fi


