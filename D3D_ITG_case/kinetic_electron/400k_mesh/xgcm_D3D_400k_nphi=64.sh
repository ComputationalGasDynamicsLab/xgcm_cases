#!/bin/bash
#SBATCH -A m499
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 6:00:00
#SBATCH -n 32
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=map_gpu:0,1,2,3
#SBATCH --job-name=D3D_100k

module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"

srun ./XGCm --kokkos-threads=1 400k.osh 400k_4.cpn \
1 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
