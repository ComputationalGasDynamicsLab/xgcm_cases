#!/bin/bash
#BSUB -P GEN170
#BSUB -W 0:30
#BSUB -nnodes 1
#BSUB -J Cyclone-590k
#BSUB -o Cyclone-590k.%J
#BSUB -e Cyclone-590k.%J

module load cuda/10.2.89
module load nsight-compute/2021.2.2
export KOKKOS_PROFILE_LIBRARY=/ccsopen/home/zhangc20/xgcm/kokkos-tools/kp_nvprof_connector.so

date
ncu --section-folder-restore
jsrun -n 6 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
ncu -f -o XGCm_ncu_%q{OMPI_COMM_WORLD_RANK} --set default \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 0 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0

date
