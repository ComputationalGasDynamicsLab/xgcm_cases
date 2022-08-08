On Perlmutter, compile with:
 - kokkos 3.4.01
 - gcc 9.3.0
 - cuda 11.1.1
 - cmake 3.20.3
 - omega_h and pumi_pic master branch
 - PETSc 3.16.1
 - XGCm cz/perlmutter branch
by loading the required modules:
```
module load PrgEnv-gnu
module load cpe-cuda
module load cmake/3.20.5
module load cuda/11.1.1
```

Case run on 2 node of NERSC Perlmutter system:
 - 8 GPUs used
 - 20 million particles per GPU
 - PETSc CPU solver is used due to PETSc hangs with running on multiple nodes with GPU solver
