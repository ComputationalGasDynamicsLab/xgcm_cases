#!/bin/bash
#SBATCH -A m499_g
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 1:00:00
#SBATCH -n 8
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=map_gpu:0,1,2,3
#SBATCH --job-name=Cyclone_590k

module load PrgEnv-gnu
module load cudatoolkit/21.9_11.4
module load cpe-cuda
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"
export MPICH_ABORT_ON_ERROR=1
ulimit -c unlimited
ulimit -a

# below lines "-n - c, etc." are not needed, but jut keep it here in case
# modifying this script to run in interactive mode.
srun -n 8 -c 32 --gpus 4 --gpus-per-task 1 --ntasks-per-node=4 \
--gpu-bind=map_gpu:0,1,2,3 \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
