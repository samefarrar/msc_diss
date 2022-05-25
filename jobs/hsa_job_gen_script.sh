cd /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/
declare -i N;
N=1;
for f in *_R1.fastq.gz; do
  ISOLATE=${f%_R1.fastq.gz};
  FORWARD_FASTQ=${f};
  REVERSE_FASTQ=${f%_R1.fastq.gz}_R2.fastq.gz;
  echo -en "module load anaconda3/personal\n
  source activate SPAdes_env\n
  module load spades/3.10.1\n
  cd /rds/general/user/sef17/home/msc_diss/data/gen/trimmed
  spades.py -1 ${FORWARD_FASTQ} -2 ${REVERSE_FASTQ} --only-assembler --threads 2 -k 21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85 -o /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/${ISOLATE}_spades --tmp-dir /rds/general/user/sef17/ephemeral\n
  rm -rf /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/${ISOLATE}_spades/K*" > /rds/general/user/sef17/home/msc_diss/jobs/SPAdes/hsa_spades_job.$N;
  chmod 770 /rds/general/user/sef17/home/msc_diss/jobs/SPAdes/hsa_spades_job.$N;
  N=($N+1);
done
N=($N-1)

echo "
#PBS -o SPAdes/hsa_spades.^array_index^.run.o
#PBS -e SPAdes/hsa_spades.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N hsa_spades_job
#PBS -J 1-$N

/rds/general/user/sef17/home/msc_diss/jobs/SPAdes/hsa_spades_job.\${PBS_ARRAY_INDEX}
" > /rds/general/user/sef17/home/msc_diss/jobs/spades_array.sh
