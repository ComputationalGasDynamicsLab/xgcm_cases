On Ascent, compile with:
 - kokkos 3.1.01
 - gcc 7.4.0
 - cuda 11.0.2
 - cmake 3.18.2
 - omega_h and pumi_pic master branch
 - PETSc 3.16.1
 - XGCm cz/perlmutter branch

Case run on 1 node of OLCF Ascent system:
 - 6 GPUs used
 - 20 million particles per GPU

To use `kokkos-tools/kp_nvprof_connector`, need to build with `develop` branch of `kokkos-tools`.
