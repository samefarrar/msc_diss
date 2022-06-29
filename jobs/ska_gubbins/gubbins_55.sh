#! /bin/sh
#PBS -o logs/gubbins55.run.o
#PBS -e logs/gubbins55.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N gubbins_55

module load anaconda3/personal
source activate gubbins
cd ~/msc_diss/result/ska_alignment
run_gubbins.py --prefix gubbins_55 /rds/general/user/sef17/home/msc_diss/result/ska_alignment/GPSC_55.aln