#! /bin/sh
#PBS -o SPAdes/logs/spades.^array_index^.run.o
#PBS -e SPAdes/logs/spades.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N spades_array_job
#PBS -J 1-1400

/rds/general/user/sef17/home/msc_diss/jobs/SPAdes/spades_job.${PBS_ARRAY_INDEX}

