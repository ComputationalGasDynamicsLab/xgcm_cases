#!/bin/bash
#BSUB -P PHY122
#BSUB -W 4:00
#BSUB -nnodes 2
#BSUB -J Cyclone-590k
#BSUB -o Cyclone-590k.%J
#BSUB -e Cyclone-590k.%J

module load cuda/10.2.89

date
jsrun -n 8 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
date

