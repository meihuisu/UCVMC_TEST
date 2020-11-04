#!/bin/bash
#SBATCH -p scec
#SBATCH --ntasks=8
#SBATCH -N 8 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=00:30:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_ucvm2mesh.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_ucvm2mesh.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env.sh
export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc

###############################################################################

cd $SLURM_SUBMIT_DIR

srun -v --mpi=pmi2 ${UCVM_INSTALL_PATH}/bin/ucvm2mesh-mpi -f ${TEST_SRC_PATH}/workshopDemo/hpc_ucvm2mesh.conf

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
