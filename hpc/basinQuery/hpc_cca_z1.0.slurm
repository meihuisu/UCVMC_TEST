#!/bin/bash
#SBATCH --ntasks=40 
#SBATCH -N 20
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=04:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cca_z1.0.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cca_z1.0.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END


source /home/scec-00/mei/setup_env.sh

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.first,${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.last,${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.result,${TEST_TOP_PATH}/RESULT/hpc_cca_z1.0.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cca -i 20 -v 1000 -l 33.35,-123.0 -s 0.005 -x 1551 -y 1201

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
