#!/bin/bash
#BSUB -P FUS157
#BSUB -W 1:00
##BSUB -q debug
#BSUB -nnodes 1
#BSUB -J Cyclone-1k
#BSUB -o Cyclone-1k.%J
#BSUB -e Cyclone-1k.%J

module load gcc/11.4.0
module load cuda/11.7.1

date
jsrun -n 4 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
./XGCm --kokkos-num-threads=1 1000mesh.osh 1000mesh_4.cpn \
1 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
date

