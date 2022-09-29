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
module load gcc/11.2.0
module load cuda/11.5.2
module load cmake/3.20.2
```

Note:

Case run on 2 node of OLCF Summit system:
 - 8 GPUs used
 - number of ion particles per GPU: 1.25, 2.5, 5, 10, 20, 32, 40 millions for different case.
