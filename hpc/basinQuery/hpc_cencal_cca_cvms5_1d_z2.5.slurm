#!/bin/bash
#SBATCH --ntasks=40 
#SBATCH -N 20
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=10:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.err
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

##./plot_horizontal_slice.py -b 30,-130 -u 42,-113 -s 0.01 -e 0 -d vs -a s -c cencal,cca,cvms5,1d -o cross_study_depth_0.png

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi_complete -b ${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_1d_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cencal,cca,cvms5,1d -i 20 -v 2500 -l 30,-130.0 -s 0.005 -x 3400 -y 2400
#-i 20 -v 2500 -l 33.35,-123.0 -s 0.005 -x 1551 -y 1201

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
