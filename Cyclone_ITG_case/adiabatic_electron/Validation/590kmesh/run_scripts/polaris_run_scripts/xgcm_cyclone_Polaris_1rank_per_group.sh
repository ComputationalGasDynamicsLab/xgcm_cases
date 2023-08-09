#!/bin/bash -l
#PBS -N Cyclone_ITG
#PBS -l select=1:ncpus=4
#PBS -l walltime=0:60:00
#PBS -A ATPESC2023
#PBS -q ATPESC
#PBS -l filesystems=home:grand:eagle

module load PrgEnv-gnu/8.3.3
module load cudatoolkit-standalone/11.8.0
module load cmake/3.23.2

NNODES=`wc -l < $PBS_NODEFILE`
NRANKS_PER_NODE=4 # Number of MPI ranks to spawn per node
NDEPTH=16 # Number of hardware threads per rank (i.e. spacing between MPI ranks)
NTHREADS=1 # Number of software threads per rank to launch (i.e. OMP_NUM_THREADS)
NTOTRANKS=$(( NNODES * NRANKS_PER_NODE ))
num_gpus=${NTOTRANKS}
echo "NUM_OF_NODES= ${NNODES} TOTAL_NUM_RANKS= ${NTOTRANKS} RANKS_PER_NODE= ${NRANKS_PER_NODE} THREADS_PER_RANK= ${NTHREADS}"

cd ${PBS_O_WORKDIR}
mpiexec -n ${NTOTRANKS} --ppn ${NRANKS_PER_NODE} --depth=${NDEPTH} -env \
OMP_NUM_THREADS=${NTHREADS} --cpu-bind depth ./set_affinity_gpu_polaris.sh \
./XGCm 590kmesh.osh 590kmesh_6.cpn \
1 1 bfs bfs 1 1 0 3 input_xgcm petsc petsc_xgcm.rc \
-use_gpu_aware_mpi 0

# Note (1): to be able to view PETSc time log for GPU computation, need to add
# "-log_view_gpu_time"; this will however results in a 10-20% increase in
# overallPETSc solve time
# Note (2): OpenMP related environment variables are not used in the simulation if we do not enable OpenMP in Kokkos.
# Usually OpenMP is not enable in XGCm simulation. It is just put here for testing enabling OpenMP for a different purpose.
