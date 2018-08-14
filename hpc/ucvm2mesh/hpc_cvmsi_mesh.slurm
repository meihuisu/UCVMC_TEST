#!/bin/bash
#SBATCH --ntasks=8
#SBATCH -N 4 
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=02:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvmsi_mesh.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cvmsi_mesh.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

## setup mpi environment
source /usr/usc/openmpi/default/setup.sh

## prepend anaconda's bin, including python2.7
export PATH=/home/scec-00/mei/anaconda2/bin:$PATH

## prepend velocity model's lib
export TEST_UCVMC_TARGET=/home/scec-00/mei/TARGET_UCVMC
export UCVM_SRC_PATH=$TEST_UCVMC_TARGET/UCVMC
export UCVM_INSTALL_PATH=$TEST_UCVMC_TARGET/install

if [ $LD_LIBRARY_PATH ] ; then
  export LD_LIBRARY_PATH=$UCVM_INSTALL_PATH/lib/euclid3/lib:$UCVM_INSTALL_PATH/lib/proj-4/lib:$UCVM_INSTALL_PATH/model/cvms426/lib:$UCVM_INSTALL_PATH/model/cencal/lib:$LD_LIBRARY_PATH
  else
    export LD_LIBRARY_PATH=$UCVM_INSTALL_PATH/lib/euclid3/lib:$UCVM_INSTALL_PATH/lib/proj-4/lib:$UCVM_INSTALL_PATH/model/cvms426/lib:$UCVM_INSTALL_PATH/model/cencal/lib
fi
#echo $LD_LIBRARY_PATH

export TEST_TOP_PATH=/home/scec-00/mei/UCVM_REVIEW
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/ucvm2mesh

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/ucvm2mesh-mpi .
cp ${TEST_SRC_PATH}/hpc_cvmsi_mesh.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/ucvm2mesh-mpi -f hpc_cvmsi_mesh.conf

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
