#!/bin/bash
#SBATCH --ntasks=40 
#SBATCH -N 20
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=04:00:00 
#SBATCH -o /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cca_z2.5.out
#SBATCH -e /home/scec-00/mei/UCVM_REVIEW/RESULT/hpc_cca_z2.5.err
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
export TEST_SRC_PATH=${TEST_TOP_PATH}/UCVMC_TEST/hpc/reviewStudy

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/bin/basin_query_mpi .
cp ${UCVM_INSTALL_PATH}/conf/ucvm.conf .

srun -v --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.first,${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.firstOrSecond,${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.last,${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.secondOnly,${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.threeLast -o ${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.result,${TEST_TOP_PATH}/RESULT/hpc_cca_z2.5.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cca -i 20 -v 2500 -l 33.35,-123.0 -s 0.005 -x 1551 -y 1201

ret=$?

echo "Slurm Jobs done" `date`
exit $ret
