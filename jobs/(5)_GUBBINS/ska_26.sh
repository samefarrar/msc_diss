#! /bin/sh
#PBS -o logs/ska26.run.o
#PBS -e logs/ska26.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N ska_26

module load anaconda3/personal
source activate gubbins
generate_ska_alignment.py --reference /rds/general/user/sef17/home/msc_diss/ref/gps_refs/GPSC26_reference.fasta --fasta /rds/general/user/sef17/home/msc_diss/result/cluster_lists/GPSC_26.list --out ~/msc_diss/result/ska_alignment/GPSC_26.aln