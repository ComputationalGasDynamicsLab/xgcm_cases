On Perlmutter, compile with:
- kokkos 3.4.01: https://github.com/kokkos/kokkos
- omega_h master branch: https://github.com/sandialabs/omega_h
- PUMIPic master branch: https://github.com/SCOREC/pumi-pic
- EnGPar master branch: https://github.com/SCOREC/EnGPar
- PETSc 3.16.2: https://gitlab.com/petsc/petsc
- XGCm cz/perlmutter branch: https://github.com/SCOREC/xgcm
 
using `cudatoolkit/21.9_11.4`, `gcc 10.3.0`, `cray-mpich 8.1.11` by loading:
```
module load PrgEnv-gnu
module load cudatoolkit/21.9_11.4
module load cpe-cuda
module load craype-accel-nvidia80
module load cmake/3.22.0
module unload darshan
```
`module load craype-accel-nvidia80` is just to be able to use the `GPU-aware MPI` later: https://docs.nersc.gov/systems/perlmutter/#gpu-aware-mpi.


Case run on 2 node of NERSC Perlmutter system:
 - 8 GPUs used;
 - 20 million particles per GPU;
 - run for more than 500 time steps to observe the crash;
 - the code crashed at `568` time step in one case;
 - in a different run, it can crash at a slightly different time step.
