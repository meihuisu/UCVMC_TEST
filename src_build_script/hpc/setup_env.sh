#!/bin/bash

## setup mpi environment
source /usr/usc/openmpi/default/setup.sh

## prepend anaconda's bin, including python2.7
export PATH=/home/scec-00/mei/anaconda2/bin:$PATH

## UCVMC specific setup
export TEST_UCVMC_TARGET=/home/scec-00/mei/TARGET_UCVMC
export UCVM_SRC_PATH=$TEST_UCVMC_TARGET/UCVMC
export UCVM_INSTALL_PATH=$TEST_UCVMC_TARGET/install

## prepend UCVMC's bin directory
export PATH=$UCVM_INSTALL_PATH/bin:$PATH

## prepend velocity model's lib
if [ $LD_LIBRARY_PATH ] ; then
  export LD_LIBRARY_PATH=$UCVM_INSTALL_PATH/lib/euclid3/lib:$UCVM_INSTALL_PATH/lib/proj-4/lib:$UCVM_INSTALL_PATH/model/cvms426/lib:$UCVM_INSTALL_PATH/model/cencal/lib:$UCVM_INSTALL_PATH/model/cca/lib:$LD_LIBRARY_PATH
  else
    export LD_LIBRARY_PATH=$UCVM_INSTALL_PATH/lib/euclid3/lib:$UCVM_INSTALL_PATH/lib/proj-4/lib:$UCVM_INSTALL_PATH/model/cvms426/lib:$UCVM_INSTALL_PATH/model/cencal/lib:$UCVM_INSTALL_PATH/model/cca/lib:
fi
#echo $LD_LIBRARY_PATH

## setup python script from ucvmc
if [ $PYTHONPATH ] ; then 
  export PYTHONPATH=$PYTHONPATH:$UCVM_INSTALL_PATH/utilities/pycvm
  else
     export PYTHONPATH=$UCVM_INSTALL_PATH/utilities/pycvm
fi
#echo $PYTHONPATH
 
alias goto='cd /home/scec-00/mei'
alias toresult='cd /home/scec-00/mei/UCVM_REVIEW/RESULT'
alias totest='cd /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/basinQuery'
alias toplot='cd /home/scec-00/mei/TARGET_UCVMC/install/utilities'
alias topytest='cd /home/scec-00/mei/UCVM_REVIEW/UCVM_TEST/hpc'
alias tocca='cd /home/scec-00/mei/TARGET_UCVMC/UCVMC/work/model/cca'
alias tobin='cd /home/scec-00/mei/TARGET_UCVMC/install/bin'
alias tosrc='cd /home/scec-00/mei/TARGET_UCVMC/UCVMC/src/ucvm'


