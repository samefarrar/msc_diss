#! /bin/sh
#PBS -o logs/gubbins334.run.o
#PBS -e logs/gubbins334.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N gubbins_334

module load anaconda3/personal
source activate gubbins
cd ~/msc_diss/result/ska_alignment
run_gubbins.py --prefix gubbins_334 /rds/general/user/sef17/home/msc_diss/result/ska_alignment/GPSC_334.aln