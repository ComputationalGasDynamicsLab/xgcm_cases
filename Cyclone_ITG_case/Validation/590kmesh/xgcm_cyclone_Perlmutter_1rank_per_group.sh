#!/bin/bash
#SBATCH -A m499
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 0:30:00
#SBATCH -n 8
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=map_gpu:0,1,2,3
#SBATCH --job-name=Cyclone_590k

module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export OMP_NUM_THREADS=32
ulimit -c unlimited

srun ./XGCm 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0

# Note: OpenMP related environment variables are not used in the simulation if we do not enable OpenMP in Kokkos.
# Usually OpenMP is not enable in XGCm simulation. It is just put here for testing enabling OpenMP for a different purpose.
