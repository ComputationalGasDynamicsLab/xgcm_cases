#!/bin/bash
#SBATCH -A m499_g
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 0:05:00
#SBATCH -n 8
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=map_gpu:0,1,2,3
#SBATCH --job-name=Cyclone_590k

module load PrgEnv-gnu
module load cudatoolkit/21.9_11.4
module load cpe-cuda
module load cmake/3.22.0
export SLURM_CPU_BIND="cores"

srun ./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 0 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
