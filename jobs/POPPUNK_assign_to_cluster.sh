#! /bin/sh
#PBS -N poppunk_assign_to_cluster
#PBS -o poppunk_assign_to_cluster.o
#PBS -e poppunk_assign_to_cluster.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=1000gb

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

poppunk_assign --db /rds/general/user/sef17/home/msc_diss/ref/reference_db/GPS_v5 --query /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/all_12f.txt --output /rds/general/user/sef17/home/msc_diss/result/poppunk_clusters --threads 16 --update-db