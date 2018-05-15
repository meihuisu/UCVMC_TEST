#!/bin/bash
## USC hpc => hpc-login3.usc.edu

## setup python environment
source /usr/usc/python/3.5.2/setup.sh

## setup mpi environment
source /usr/usc/openmpi/default/setup.sh

## prepend anaconda's bin, including python2.7
export PATH=/home/scec-00/mei/anaconda2/bin:$PATH

## prepend velocity model's lib
export TEST_UCVM_TARGET=/home/scec-00/mei/TARGET_UCVM
export UCVM_SRC_PATH=$TEST_UCVM_TARGET/UCVM
export UCVM_INSTALL_PATH=$TEST_UCVM_TARGET/install
export GEOS_DIR=/home/scec-00/mei/TARGET_UCVM/install

## prepend anaconda's bin, including python2.7
#export PATH=/home/scec-00/mei/anaconda2/bin:$PATH

alias goto='cd /home/scec-00/mei'
alias toresult='cd /home/scec-00/mei/UCVM_REVIEW/RESULT'
alias totest='cd /home/scec-00/mei/UCVM_REVIEW/UCVMC_TEST/hpc/basinQuery'
alias toplot='cd /home/scec-00/mei/TARGET_UCVMC/install/utilities'
alias topytest='cd /home/scec-00/mei/UCVM_REVIEW/UCVM_TEST/hpc'
alias tocca='cd /home/scec-00/mei/TARGET_UCVMC/UCVMC/work/model/cca'
alias tobin='cd /home/scec-00/mei/TARGET_UCVMC/install/bin'
alias tosrc='cd /home/scec-00/mei/TARGET_UCVMC/UCVMC/src/ucvm'

source $UCVM_INSTALL_PATH/bin/activate


