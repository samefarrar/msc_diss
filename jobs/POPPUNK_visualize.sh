#! /bin/sh
#PBS -N poppunk_visualize_nj
#PBS -o poppunk_visualize_nj.o
#PBS -e poppunk_visualize_nj.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=500gb

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

poppunk_visualise --ref-db /rds/general/user/sef17/home/msc_diss/result/poppunk_clusters --output /rds/general/user/sef17/home/msc_diss/result/poppunk_geo_vis  --threads 8 --microreact --previous-clustering /rds/general/user/sef17/home/msc_diss/result/poppunk_clusters/poppunk_clusters_clusters.csv --info-csv /rds/general/user/sef17/home/msc_diss/ref/12F_from_GPS_epidata.csv