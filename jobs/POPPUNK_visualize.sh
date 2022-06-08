#! /bin/sh
#PBS -N poppunk_visualize_nj
#PBS -o poppunk_visualize_nj.o
#PBS -e poppunk_visualize_nj.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=1000gb

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

poppunk_visualise --ref-db /rds/general/user/sef17/home/msc_diss/result/all_assign --output /rds/general/user/sef17/home/msc_diss/result/all_geo_vis  --threads 15 --microreact --previous-clustering /rds/general/user/sef17/home/msc_diss/result/all_assign/all_assign_clusters.csv --info-csv /rds/general/user/sef17/home/msc_diss/ref/12F_from_GPS_epidata.csv