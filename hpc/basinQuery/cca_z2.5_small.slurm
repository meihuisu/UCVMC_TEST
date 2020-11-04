#!/bin/bash
#SBATCH --ntasks=20 
#SBATCH -N 4 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=00:30:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/small_cca_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/small_cca_z2.5.err
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

#ARGS="-b 33.5,-121 -u 35,-118.5 -c cca -s 0.005"

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/small_cca_z2.5.first,${TEST_TOP_PATH}/RESULT/small_cca_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/small_cca_z2.5.last,${TEST_TOP_PATH}/RESULT/small_cca_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/small_cca_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/small_cca_z2.5.result,${TEST_TOP_PATH}/RESULT/small_cca_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cca -i 20 -v 2500 -l 33.5,-121 -s 0.005 -x 501 -y 301

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
