#! /bin/sh
#PBS -N spades_array_job
#PBS -o spades.^array_index^.run.o
#PBS -e spades.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N spades_job
#PBS -J 1-64

cd $PBS_O_WORKDIR
/rds/general/user/sef17/home/msc_diss/jobs/SPAdes/spades_job.${PBS_ARRAY_INDEX}
