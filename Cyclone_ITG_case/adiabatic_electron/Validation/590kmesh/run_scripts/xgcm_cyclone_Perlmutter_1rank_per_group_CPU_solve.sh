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

srun ./XGCm_CPU 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0 -dm_vec_type mpi -dm_mat_type mpiaij

# note: override default matrix and vector types in "petsc_xgcm.rc", and use
# "mpi" and "mpiaij" types for vector and matrix through input arguments
# "-dm_vec_type mpi -dm_mat_type mpiaij"
