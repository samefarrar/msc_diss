
#PBS -o SPAdes/hsa_spades.^array_index^.run.o
#PBS -e SPAdes/hsa_spades.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N hsa_spades_job
#PBS -J 1-1336

/rds/general/user/sef17/home/msc_diss/jobs/SPAdes/hsa_spades_job.${PBS_ARRAY_INDEX}

