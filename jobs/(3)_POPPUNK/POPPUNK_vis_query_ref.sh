#! /bin/sh
#PBS -N poppunk_visualize_query_ref
#PBS -o poppunk_visualize_qr.o
#PBS -e poppunk_visualize_qr.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=1000gb

module load anaconda3/personal

now=$(date +"%d_%m_%Y")

source activate poppunk

poppunk_visualise --ref-db /rds/general/user/sef17/home/msc_diss/ref/reference_db/GPS_v6 --query-db /rds/general/user/sef17/home/msc_diss/result/all_assign --previous-clustering /rds/general/user/sef17/home/msc_diss/result/all_assign/all_assign_clusters.csv --output /rds/general/user/sef17/home/msc_diss/result/vis_query_ref_$now --threads 16 --microreact --external-clustering /rds/general/user/sef17/home/msc_diss/ref/reference_db/GPS_v6_external_clusters.csv