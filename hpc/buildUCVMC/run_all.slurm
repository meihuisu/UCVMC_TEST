#!/bin/bash
#SBATCH --ntasks=2 
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=01:00:00 
#SBATCH -o /home/scec-00/mei/ucvmc_19_4/install/utilities/run_all.out
#SBATCH -e /home/scec-00/mei/ucvmc_19_4/install/utilities/run_all.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env_proj.sh

###############################################################################

cd /home/scec-00/mei/ucvmc_19_4/install/utilities
./run-all

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
