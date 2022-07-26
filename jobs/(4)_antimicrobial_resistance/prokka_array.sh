
#! /bin/sh
#PBS -o prokka_jobs/logs/prokka.^array_index^.run.o
#PBS -e prokka_jobs/logs/prokka.^array_index^.run.e
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N prokka_array_job
#PBS -J 1-1392

/rds/general/user/sef17/home/msc_diss/jobs/\(4\)_antimicrobial_resistance/prokka_jobs/prokka_job.${PBS_ARRAY_INDEX}

