#!/bin/bash
#SBATCH --ntasks=10 
#SBATCH -N 2 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=01:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvmh_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvmh_z2.5.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

## setup mpi environment
source /usr/usc/openmpi/default/setup.sh

## setup mei environment
source /home/scec-00/mei/setup_env.sh

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi_complete .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi_complete -b ${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cvmh_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cvmh -i 20 -v 2500 -l 33.35,-121 -s 0.005 -x 700 -y 600

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
