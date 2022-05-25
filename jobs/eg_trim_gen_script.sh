# declare an integer object
declare -i N;
N=1;
# iterate all raw fastq files
for f in *_R1.fastq.gz; do
  #define variables
  ISOLATE=${f%_R1.fastq.gz};
  FORWARD_FASTQ=${f};
  REVERSE_FASTQ=${f%_R1.fastq.gz}_R2.fastq.gz;
  # print trimmomatic jobs for all fastqs and run
  echo -en "module load anaconda3/personal\nsource activate trim039\ncd /rds/general/user/sef17/home/msc_diss/data/orig/12F_epidemiology/raw_fastqs\njava -jar /rds/general/user/sef17/home/msc_diss/ref/Trimmomatic-0.39/dist/jar/trimmomatic-0.39.jar PE -threads 4 -phred33 ${FORWARD_FASTQ}  ${REVERSE_FASTQ} /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/${ISOLATE}_R1.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/${ISOLATE}_R1_unpaired.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/${ISOLATE}_R2.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/${ISOLATE}_R2_unpaired.fastq.gz ILLUMINACLIP:/rds/general/user/sef17/home/msc_diss/ref/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36" > /rds/general/user/sef17/home/msc_diss/jobs/Trim/trim_job.$N;
  chmod 770 /rds/general/user/sef17/home/msc_diss/jobs/Trim/trim_job.$N;
  N=($N+1);
done
# get the correct number of jobs to run
N=($N-1)

echo "
#PBS -o trim.^array_index^.run.o
#PBS -e trim.^array_index^.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=4:mem=16gb
#PBS -N trim_job
#PBS -J 1-$N

/rds/general/user/sef17/home/msc_diss/jobs/Trim/trim_job.\${PBS_ARRAY_INDEX}
" > /rds/general/user/sef17/home/msc_diss/jobs/trim_array.sh