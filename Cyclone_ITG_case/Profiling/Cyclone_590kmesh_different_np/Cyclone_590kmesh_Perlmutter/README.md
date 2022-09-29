Note: Perlmutter compilation and run scripts are outdated; need to be updated. 
On Perlmutter, compile with:
```
 - kokkos 3.4.01
 - gcc 11.2.0
 - cuda 11.7
 - cmake 3.22
 - omega_h and pumi_pic master branch
 - PETSc 3.16.6
 - XGCm master branch
```
by loading the required modules:
```
module load PrgEnv-gnu
module load cudatoolkit/11.7
module load craype-accel-nvidia80
module load cmake/3.22.0
```

Note:

- `module load craype-accel-nvidia80` is just to be able to use the `GPU-aware MPI` later: https://docs.nersc.gov/systems/perlmutter/#gpu-aware-mpi.


Case run on 2 node of NERSC Perlmutter system:
 - 8 GPUs used
 - number of ion particles per GPU: 5, 10, 20, 40, 80, 120 millions for different case.
