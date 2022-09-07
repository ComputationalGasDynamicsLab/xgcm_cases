On Summit, compile with:
 - gcc 11.2.0
 - cuda 10.2.89
 - cmake 3.20.2
by loading the following modules:
```
module load gcc/11.2.0
module load cuda/11.5.2
module load cmake/3.20.2
```
 - kokkos version 3.4.01: https://github.com/kokkos/kokkos
 - omega_h master branch at commit 11eb25d: https://github.com/SCOREC/omega_h
 - pumi_pic master branch at commit fea3a38: https://github.com/SCOREC/pumi-pic
 - PETSc version 3.16.2: https://gitlab.com/petsc/petsc
 - XGCm master branch at commit 3c78e45: https://github.com/SCOREC/xgcm 

Case run on 2 or 8 nodes of OLCF Summit system with:
 - 20 million particles per GPU
 - 200 time steps
 - 8 GPUs for case with 1 MPI rank per group
 - 48 GPUs for case with 6 MPI ranks per group
 - With 48 GPUs, the simulation has less noise due to larger number of particles

For 1 MPI rank per group case, run with job submission script:
- xgcm_cyclone_summit_1rank_per_group.sh

For 6 MPI ranks per group case, run with job submission script:
- xgcm_cyclone_summit_6ranks_per_group.sh

