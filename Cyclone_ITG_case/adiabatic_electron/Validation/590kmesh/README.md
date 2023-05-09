On Summit, compile with:
 - gcc 11.2.0
 - cuda 11.7
 - cmake 3.22.0
by loading the following modules:
```
module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
module load cmake/3.22.0
```
using the following code versions:
```
 - kokkos 3.7.01: https://github.com/kokkos/kokkos
 - omega_h master branch: https://github.com/SCOREC/omega_h, at commit: 1524449
 - EnGPar master branch: https://github.com/SCOREC/EnGPar, at commit: 57b3f57
 - Cabana 0.5.0: https://github.com/ECP-copa/Cabana
 - PUMIPic master branch: https://github.com/SCOREC/pumi-pic, at commit: a1cadc0
 - PETSc 3.16.6: https://gitlab.com/petsc/petsc
 - XGCm master branch: https://github.com/SCOREC/xgcm at commit: 90dbbe8
```
Refer to [XGCm build scripts](https://github.com/zhangchonglin/XGCm_build_scripts/tree/main/Perlmutter/Perlmutter_gcc11.2.0_cuda11.7_kokkos3.7.01) for detailed build scripts.

Case run on 2 or 8 nodes of OLCF Summit system with:
```
 - 20 million particles per GPU
 - 200 time steps
 - 8 GPUs for case with 1 MPI rank per group
 - 48 GPUs for case with 6 MPI ranks per group
 - With 48 GPUs, the simulation has less noise due to larger number of particles
```
It can also be run on 2 or 12 nodes of NERSC Perlmutter system.

For 1 MPI rank per group case, run with either job submission script:
```
- xgcm_cyclone_summit_1rank_per_group.sh
```
or,
```
xgcm_cyclone_Perlmutter_1rank_per_group.sh
```

For 6 MPI ranks per group case, run with either job submission script:
```
- xgcm_cyclone_summit_6ranks_per_group.sh
```
or,
```
xgcm_cyclone_Perlmutter_6ranks_per_group.sh
```

### Note for running with AmgX through AmgXWrapper and PETSc:
Currently when run with `PETSc 3.15.2` or `PETSc 3.16.6`, the simulation is
 working fine. However, it requires specific types of `PETSc` vector and matrix:
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
