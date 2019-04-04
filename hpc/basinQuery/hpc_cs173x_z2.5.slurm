#!/bin/bash
#SBATCH --ntasks=20 
#SBATCH -N 10 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=20:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cs173x_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cs173x_z2.5.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env.sh
## setup mpi environment
source /usr/usc/openmpi/default/setup.sh

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi_complete .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

##original, -m cs173 -i 20 -v 2500 -l 31,-128.0 -s 0.01 -x 1600 -y 1100

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi_complete -b ${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cs173 -i 20 -v 2500 -l 33.35,-118 -s 0.005 -x 200 -y 200

#srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi_complete -b ${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cs173x_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cs173 -i 20 -v 2500 -l 33.35,-123.0 -s 0.005 -x 1551 -y 1201

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
