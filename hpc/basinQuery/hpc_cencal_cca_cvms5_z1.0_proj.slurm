#!/bin/bash
#SBATCH --ntasks=40 
#SBATCH -N 20
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=10:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env_proj.sh

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/basinQuery

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

##./plot_horizontal_slice.py -b 30,-130 -u 42,-113 -s 0.01 -e 0 -d vs -a s -c cencal,cca,cvms5,1d -o cross_study_depth_0.png

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.first,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.last,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.result,${TEST_TOP_PATH}/RESULT/hpc_cencal_cca_cvms5_z1.0_proj.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cencal,cca,cvms5 -i 20 -v 1000 -l 30,-130.0 -s 0.005 -x 3400 -y 2400

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
