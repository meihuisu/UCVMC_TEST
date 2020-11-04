#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --time=1:00:00
#SBATCH --export=NONE # This is needed to ensure a proper job environment


mycommand="./mpitest" # note "./" is used to not rely on $PATH
myargs=""         	# arguments for $mycommand
infiles=("")        	# list of input files
outfiles=("")      	# list output files

source /usr/usc/openmpi/default/setup.sh

#Get the number of processors assigned by Slurm
echo "Running on $SLURM_NTASKS processors: $SLURM_NODELIST"

# set up the job and input files, exiting if anything went wrong

cd $SLURM_SUBMIT_DIR || exit 1

for file in ${infiles[@]}; do
   cp $file $TMPDIR
done

cd $TMPDIR || exit 1

# run the command, saving the exit value
echo "Running $mycommand"
srun --ntasks=${SLURM_NTASKS} --mpi=pmi2 $SLURM_SUBMIT_DIR/$mycommand $myargs
# Using srun is the preferred way to launch mpi programs but mpirun will work.


ret=$?

#get the output files
cd "$SLURM_SUBMIT_DIR"

for file in ${outfiles[@]}; do
   cp ${TMPDIR}/${file} $file
done

echo "Done " `date`
exit $ret

