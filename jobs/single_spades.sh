#PBS -o SPAdes/hsa_spades.single.run.o
#PBS -e SPAdes/hsa_spades.single.run.e
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N hsa_spades_job

/rds/general/user/sef17/home/msc_diss/jobs/SPAdes/spades_job.150