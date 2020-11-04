#!/bin/bash
#SBATCH --ntasks=2 
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=00:10:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/ucvmc_build.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/ucvmc_build.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env.sh
export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

cd $SLURM_SUBMIT_DIR
cp /home/scec-00/mei/run-build-UCVMC-next .

srun -v --mpi=pmi2 ./run-build-UCVMC-next

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
