# script to run the job in interactive mode.
# run the following line to get 2 interactive node:
# salloc --nodes 2 --qos interactive --time 02:00:00 --constraint gpu --gpus 4 --account=m499_g

module load PrgEnv-gnu
module load cudatoolkit/21.9_11.4
module load cpe-cuda
module load craype-accel-nvidia80
export SLURM_CPU_BIND="cores"
export MPICH_ABORT_ON_ERROR=1
ulimit -c unlimited
ulimit -a

srun -n 8 -c 32 --gpus 8 --gpus-per-task 1 --ntasks-per-node=4 \
--gpu-bind=map_gpu:0,1,2,3 \
./XGCm --kokkos-threads=1 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 0 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0
