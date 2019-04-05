#!/bin/bash
#SBATCH --ntasks=4 
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=01:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cvms5_z2.5_simple.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cvms5_z2.5_simple.err
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
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/hpc_cencal_cvms5_z2.5.simple -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cencal,cvms5 -i 20 -v 2500 -l 35.0,-122.5 -s 0.1 -x 16 -y 11

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
