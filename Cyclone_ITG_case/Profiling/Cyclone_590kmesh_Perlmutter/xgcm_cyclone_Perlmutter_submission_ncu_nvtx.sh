#!/bin/bash
#SBATCH -A m499
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 0:10:00
#SBATCH -n 8
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=map_gpu:0,1,2,3
#SBATCH --job-name=Cyclone_590k

module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
export KOKKOS_PROFILE_LIBRARY=/global/homes/z/zhangc20/xgcm/kokkos-tools/kp_nvprof_connector.so
export SLURM_CPU_BIND="cores"

srun ncu --target-processes all -f -o XGCm_profile_ncu_%q{SLURM_PROCID} \
--nvtx --nvtx-include "gyroScatterEFF/" --set full \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm_1step petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0


# Belows are used to profile other GPU kernels
#--nvtx --nvtx-include "gyroScatterEFF/" --set full \
#--nvtx --nvtx-include "ion_push_op/" --set full \
#--nvtx --nvtx-include "xgcm_scatterToMappedVerts/" --set full \
#--nvtx --nvtx-include "gyroScatterEFF_cab/" --set full \
#--nvtx --nvtx-include "savePtclPos/" --set full \

# To profile multiple GPU kernels: use "kernel_A/*/kernel_B/*/kernel_C/"
