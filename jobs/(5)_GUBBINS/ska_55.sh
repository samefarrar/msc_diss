#! /bin/sh
#PBS -o logs/ska55.run.o
#PBS -e logs/ska55.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N ska_55

module load anaconda3/personal
source activate gubbins
generate_ska_alignment.py --reference /rds/general/user/sef17/home/msc_diss/ref/gps_refs/GPSC55_reference.fasta --fasta /rds/general/user/sef17/home/msc_diss/result/cluster_lists/GPSC_55.list --out ~/msc_diss/result/ska_alignment/GPSC_55.aln