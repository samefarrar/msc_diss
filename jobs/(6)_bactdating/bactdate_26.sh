#! /bin/sh
#PBS -o logs/bactdate26.run.o
#PBS -e logs/bactdate26.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N bactdate_26

module load anaconda3/personal
source activate bactdating
Rscript /rds/general/user/sef17/home/msc_diss/src/R/GPSC_26_bactdate.R