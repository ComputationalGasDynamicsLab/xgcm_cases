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
using the following code versions:
```
 - kokkos version 3.4.01: https://github.com/kokkos/kokkos
 - omega_h master branch at commit 11eb25d: https://github.com/SCOREC/omega_h
 - EnGPar master branch: https://github.com/SCOREC/EnGPar, at commit: 57b3f57
 - pumi_pic master branch at commit fea3a38: https://github.com/SCOREC/pumi-pic
 - PETSc version 3.16.2: https://gitlab.com/petsc/petsc
 - XGCm master branch at commit 3c78e45: https://github.com/SCOREC/xgcm 
```
Refer to [XGCm build scripts](https://github.com/zhangchonglin/XGCm_build_scripts/tree/main/Summit_gcc11.2.0_cuda11.5.2) for detailed build scripts.

Case run on 2 or 8 nodes of OLCF Summit system with:
```
 - 20 million particles per GPU
 - 200 time steps
 - 8 GPUs for case with 1 MPI rank per group
 - 48 GPUs for case with 6 MPI ranks per group
 - With 48 GPUs, the simulation has less noise due to larger number of particles
```
For 1 MPI rank per group case, run with job submission script:
```
- xgcm_cyclone_summit_1rank_per_group.sh
```

For 6 MPI ranks per group case, run with job submission script:
```
- xgcm_cyclone_summit_6ranks_per_group.sh
```

### Note for running with AmgX through AmgXWrapper and PETSc:
Currently when run with `PETSc 3.15.2` or `PETSc 3.16.6`, the simulation is
 working fine. However, it requires specific types of `PETSc` vector and matrix type:
  - `-dm_vec_type cuda` or `-dm_vec_type mpicuda`;
  - and `-dm_mat_type aij` or `-dm_mat_type mpiaij`.

### Note for running with enabling `OpenMP`.
  - Currently, there is no `OpenMP` section in the code, the below enviroment
     variable settings are just to be consistent when `OpenMP` is eanbled. 
```
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
```
  - When `OpenMP` is enabled, the maximum team size allowed is 64 from kokkos,
    or is determined through input `OpenMP` number of threads, whichever is the
    smaller value;
  - SCS particle structure has a default team size of 32, which will be checked
    against the maximum team size allowed in kokkos. To avoid inconsistency and
    potential crash, we set:
```
export OMP_NUM_THREADS=32
```
  - If using Cabana particle structure, we do not explicitly set the team size
    in XGCm; hence, we do not need to worry about `OMP_NUM_THREADS` from
    particle structure perspective.
