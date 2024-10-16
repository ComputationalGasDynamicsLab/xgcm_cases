#!/bin/bash
#BSUB -P PHY122
#BSUB -W 0:30
#BSUB -nnodes 8
#BSUB -J Cyclone-590k
#BSUB -o Cyclone-590k.%J
#BSUB -e Cyclone-590k.%J

module load gcc/11.2.0
module load cuda/11.5.2

date
jsrun -n 48 -a 1 -c 1 -g 1 --smpiargs "-gpu" \
./XGCm_AmgX --kokkos-num-threads=1 590kmesh.osh 590kmesh_6.cpn \
6 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-cfgFileName AmgX_SolverOptions_Classical.info \
-use_gpu_aware_mpi 0 -dm_vec_type mpicuda -dm_mat_type aij \
date

