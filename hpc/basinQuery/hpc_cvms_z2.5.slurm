#!/bin/bash
#SBATCH --ntasks=10
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=04:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvms_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvms_z2.5.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env.sh

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

#./plot_z25_map.py -b 34.0,-118.0 -u 35.0,-117.00 -c cvms -s 0.05 -o phil-z25.png -a s

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi_complete .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi_complete -b ${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cvms_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cvms -i 20 -v 2500 -l 34.0,-118.0 -s 0.1 -x 100 -y 100 

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
