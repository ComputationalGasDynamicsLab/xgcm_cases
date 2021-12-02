#!/bin/bash
#BSUB -P GEN170
#BSUB -W 0:10
#BSUB -nnodes 1
#BSUB -J Cyclone-590k
#BSUB -o Cyclone-590k.%J
#BSUB -e Cyclone-590k.%J

module load cuda/10.2.89
module load nsight-systems/2021.4.1.73
export KOKKOS_PROFILE_LIBRARY=/ccsopen/home/zhangc20/xgcm/kokkos-tools/kp_nvprof_connector.so

date
jsrun -n 6 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
nsys profile -o XGCm_profile_%q{OMPI_COMM_WORLD_RANK} -f true --stats=true \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 0 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0

date
