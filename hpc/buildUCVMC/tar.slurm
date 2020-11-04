#!/bin/bash
#SBATCH --ntasks=2 
#SBATCH -N 1 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=10:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/buildUCVMC/run_etree.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/buildUCVMC/run_etree.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/scec-00/mei/setup_env_proj.sh

###############################################################################

cd $SLURM_SUBMIT_DIR
cp /home/scec-00/mei/Elnaz_etree/run-etree .
cp /home/scec-00/mei/Elnaz_etree/etree_input.txt .

srun -v --mpi=pmi2 gzip  ecompact_Elnaz2_garnervalley_cvms5_gtl_5hz_10pts_200ms.e.tar 
srun -v --mpi=pmi2 gzip Elnaz2_garnervalley_cvms5_gtl_5hz_10pts_200ms.e.tar 

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
