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

Note:
- To get correct kernel names, need to use `kokkos-tools/kp_nvprof_connector`;
- Build `kp_nvprof_connector` using the `develop` branch of `kokkos-tools`.
- To use `nsight compute` to profile a specific GPU kernel, needs
  to add the following in the run script within `srun` line:
```
ncu --target-processes all -f -o XGCm_profile_ncu_nvtx \
--nvtx --nvtx-include "gyroScatterEFF_cab/" --set full \
``
- Additionally, to profile multiple GPU kernels at the same time, need to do:
```
--nvtx_include "kernel_A/*/kernel_B/*/kernel_c/"
```
- Below is an example:
```
--nvtx --nvtx-include "gyroScatterEFF/*/ion_push_op/" --set full
```
