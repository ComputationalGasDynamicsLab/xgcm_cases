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

Weak scaling simulations are run on OLCF Summit system with:
```
 - 40 million particles per GPU
 - 5 time steps
 - 64 poloidal planes
 - 24 mesh partitions per poloidal plane 
 - changing the number of MPI ranks within each group from 1 to 16 
```
