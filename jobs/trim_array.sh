#PBS -o Trim/trim.^array_index^.run.o
#PBS -e Trim/trim.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N trim_job
#PBS -J 1-1336

/rds/general/user/sef17/home/msc_diss/jobs/Trim/trim_job.${PBS_ARRAY_INDEX}

