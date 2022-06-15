#! /bin/sh
#PBS -N poppunk_visualize_nu
#PBS -o poppunk_visualize_nu.o
#PBS -e poppunk_visualize_nu.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=1000gb

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

poppunk_visualise --ref-db /rds/general/user/sef17/home/msc_diss/ref/reference_db/GPS_v5 --query-db /rds/general/user/sef17/home/msc_diss/result/nu_assign --output /rds/general/user/sef17/home/msc_diss/result/nu_vis  --threads 16 --microreact --previous-clustering /rds/general/user/sef17/home/msc_diss/result/nu_assign/nu_assign_clusters.csv