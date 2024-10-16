# XGC build instruction

- Depending on the HPC platform, building the `xgc-es` executable accordingly.
- For `NERSC Cori KNL` node, load the following modules
```
module load cray-libsci
module switch craype-haswell craype-mic-knl
module load cray-hdf5-parallel
module load cray-fftw
module load cmake/3.18.2
export XGC_PLATFORM=cori_knl
export CRAYPE_LINK_TYPE=static
```
- Setup the build with `cmake`:
```
cmake ../ -DCMAKE_BUILD_TYPE=Debug -DXGC1=ON -DCONVERT_GRID2=ON \
          -DNEW_FLX_AIF=ON -DDELTAF_CONV=ON -DINIT_GENE_PERT=ON \
          -DRHO_PARA_DERIVS=ON -DRHO_PARA_DERIVS_CPU=ON
```
- Build `xgc-es-cpp` executable:
```make -j4 xgc-es-cpp```

# XGC run instruction

- The run script `run_cori_xgc1.sh` is setup to run the test case on `NERSC Cori KNL` with 1 nodes and 16 cores. The reason for running only 16 cores per KNL node is such that this serves as an example for debug purpose.

- on `NERSC cori`, type `sbatch run_cori_xgc1.sh` to run the test case

- on RPI aimos, type `./submit_aimos_xgc.sh` to run the test case
 - runs 200 steps without issue in about 10 minutes

- The test case contains 37k triangle elements. This test case can be used for quick code test purpose using XGC. The original test case is described here: https://github.com/PrincetonUniversity/XGC-Examples/wiki/delta-f_ITG.

- The mesh is regenerated with `XGC meshing code` in `https://github.com/SCOREC/Fusion` branch with commit around: https://github.com/SCOREC/Fusion/commit/8445f6731514259cd925d25e0839c6ea6289044e.

# Post-processing
- The `matlab_file` folder contains post-processing scripts to read in the `*.bp` file in Matlab compiled with Adios.
- Additional python based post-processing scripts will be added later.
