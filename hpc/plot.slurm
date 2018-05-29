#!/bin/bash
#SBATCH --ntasks=1 
#SBATCH -N 1
#SBATCH --mem 0 # Set to unlimited memory
#SBATCH --time=02:00:00 
#SBATCH -o /home/scec-00/mei/TARGET_UCVMC/install/utilities/m.out
#SBATCH -e /home/scec-00/mei/TARGET_UCVMC/install/utilities/m.err
#SBATCH --export=NONE 
#SBATCH --mail-user=mei@usc.edu
#SBATCH --mail-type=END

source /home/rcf-40/mei/setup_env.sh
export TEST_TOP_PATH=/home/scec-00/mei/TARGET_UCVMC/install/utilities

###############################################################################

cd $SLURM_SUBMIT_DIR
cp ${UCVM_INSTALL_PATH}/plot_cross_section.py .

srun -v ./plot_cross_section.py -b 35,-121 -u 35,-118 -h 1000 -v 100 -d vs -c cs173h -a s -s 0 -e 10000 -o cs173h_GTL_vp_santaMaria_x1_a.png
srun -v ./plot_cross_section.py -b 34.5,-121 -u 34.5,-118 -h 1000 -v 100 -d vs -c cs173h -a s -s 0 -e 10000 -o cs173h_GTL_vp_santaMaria_x2_a.png


ret=$?

echo "Slurm Jobs done" `date`
exit $ret
