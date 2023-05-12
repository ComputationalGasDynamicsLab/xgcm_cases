#!/bin/bash
#SBATCH -A m499
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 0:30:00
#SBATCH -N 2
#SBATCH --job-name=Cyclone_590k

module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
module load arm-forge
export SLURM_CPU_BIND="cores"
export OMP_STACKSIZE=2G
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export OMP_NUM_THREADS=32
ulimit -c unlimited

ddt --offline -o debug_output.html \
srun -n 8 -c 32 --gpus-per-task=1 --gpu-bind=single:1 \
./XGCm 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0

# Note (1): to be able to view PETSc time log for GPU computation, need to add
# "-log_view_gpu_time"; this will however results in a 10-20% increase in
# overallPETSc solve time
# Note (2): OpenMP related environment variables are not used in the simulation if we do not enable OpenMP in Kokkos.
# Usually OpenMP is not enable in XGCm simulation. It is just put here for testing enabling OpenMP for a different purpose.
