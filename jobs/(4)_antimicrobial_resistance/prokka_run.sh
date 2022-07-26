#! /bin/sh
#PBS -N prokka_run
#PBS -o logs/prokka_run.o
#PBS -e logs/prokka_run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=100gb

module load anaconda3/personal

source activate prokka

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

prokka -i */contigs.fasta -o /rds/general/user/sef17/home/msc_diss/result/annotated