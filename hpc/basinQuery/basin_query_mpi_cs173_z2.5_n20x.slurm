#!/bin/bash
#SBATCH --ntasks=20 
#SBATCH --time=00:30:00 
#SBATCH --export=NONE 

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

srun --ntasks=${SLURM_NTASKS} --mpi=pmi2 ${SLURM_SUBMIT_DIR}/basin_query_mpi -b ${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.first,${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.firstOrSecond,${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.last,${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.secondOnly,${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.threeLast -o ${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.result,${TEST_TOP_PATH}/RESULT/basin_query_mpi_slurm_cs173_z2.5_n20x.meta.json -f ${SLURM_SUBMIT_DIR}/ucvm.conf -m cs173 -i 20 -v 2500 -l 36.35,-120.0 -s 0.005 -x 200 -y 100

ret=$?

#get the output files
cd "$SLURM_SUBMIT_DIR"

cp ${TMPDIR}/*  ${TEST_TOP_PATH}/RESULT/

echo "Slurm Jobs done" `date`
exit $ret
