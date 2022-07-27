#! /bin/sh
#PBS -o logs/bactdate32.run.o
#PBS -e logs/bactdate32.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N bactdate_32

module load anaconda3/personal
source activate bactdating
Rscript /rds/general/user/sef17/home/msc_diss/src/R/GPSC_32_bactdate.R