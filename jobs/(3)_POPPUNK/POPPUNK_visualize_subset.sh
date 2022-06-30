#! /bin/sh
#PBS -N pp_visualize_array_job
#PBS -o pp_visualize.^array_index^.run.o
#PBS -e pp_visualize.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=200gb
#PBS -J 1-16

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

poppunk_visualise --ref-db /rds/general/user/sef17/home/msc_diss/result/poppunk_clusters --output /rds/general/user/sef17/home/msc_diss/result/visualize_${PBS_ARRAY_INDEX}  --threads 8 --microreact --previous-clustering /rds/general/user/sef17/home/msc_diss/result/poppunk_clusters/poppunk_clusters_clusters.csv --include-files /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/x${PBS_ARRAY_INDEX}