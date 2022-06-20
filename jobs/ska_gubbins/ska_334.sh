#! /bin/sh
#PBS -o logs/ska334.run.o
#PBS -e logs/ska334.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N ska_334

module load anaconda3/personal
source activate gubbins
generate_ska_alignment.py --reference /rds/general/user/sef17/home/msc_diss/ref/gps_refs/Streptococcus_pneumoniae_ASP0581_GCF_003967155_2.fa --fasta /rds/general/user/sef17/home/msc_diss/result/cluster_lists/GPSC_334.list --out ~/msc_diss/result/ska_alignment/GPSC_334.aln