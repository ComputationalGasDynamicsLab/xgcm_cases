mpirun -np 1 ./XGCm --kokkos-num-threads=1 \
1000mesh.osh 1000mesh_4.cpn \
1 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0 
