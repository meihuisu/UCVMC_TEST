#!/bin/bash
#SBATCH --ntasks=1 
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=02:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/buildUCVMC/ucvmc_build.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/buildUCVMC/ucvmc_build.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env_proj.sh

###############################################################################

cd $SLURM_SUBMIT_DIR
cp /home/scec-00/mei/run-build-UCVMC-proj-again .

srun -v ./run-build-UCVMC-proj-again

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
