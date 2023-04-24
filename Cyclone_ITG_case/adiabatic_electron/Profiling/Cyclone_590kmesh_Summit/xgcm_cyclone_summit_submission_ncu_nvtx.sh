#!/bin/bash
#BSUB -P PHY122
#BSUB -W 0:10
#BSUB -nnodes 1
#BSUB -J Cyclone-590k
#BSUB -o Cyclone-590k.%J
#BSUB -e Cyclone-590k.%J

module load gcc/7.5.0
module load cuda/10.2.89
module load nsight-compute/2021.2.2
export KOKKOS_PROFILE_LIBRARY=/ccs/home/zhangc20/pumi-pic/kokkos-tools/kp_nvprof_connector.so


date
jsrun -n 6 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
ncu --target-processes all -f -o XGCm_profile_ncu_nvtx \
--nvtx --nvtx-include "gyroScatterEFF/" --set full \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 0 0 0 3 input_xgcm_1step petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
date

# Belows are used to profile other GPU kernels
#--nvtx --nvtx-include "gyroScatterEFF/" --set full \
#--nvtx --nvtx-include "ion_push_op/" --set full \
#--nvtx --nvtx-include "xgcm_scatterToMappedVerts/" --set full \
#--nvtx --nvtx-include "gyroScatterEFF_cab/" --set full \
#--nvtx --nvtx-include "savePtclPos/" --set full \

# To profile multiple GPU kernels: use "kernel_A/*/kernel_B/*/kernel_C/"
