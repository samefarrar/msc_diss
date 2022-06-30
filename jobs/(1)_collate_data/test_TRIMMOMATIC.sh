#! /bin/sh
#PBS -N trimmomatic_test
#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=4:mem=16gb

module load anaconda3/personal
source activate trim039

cd /rds/general/user/sef17/home/msc_diss/data/orig/12F_epidemiology/raw_fastqs
java -jar /rds/general/user/sef17/home/msc_diss/ref/Trimmomatic-0.39/dist/jar/trimmomatic-0.39.jar PE -threads 8 -phred33 /rds/general/user/sef17/home/msc_diss/data/orig/12F_epidemiology/raw_fastqs/220448_H16046042510-1_R1.fastq.gz  /rds/general/user/sef17/home/msc_diss/data/orig/12F_epidemiology/raw_fastqs/220448_H16046042510-1_R2.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/220448_H16046042510-1_R1.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/220448_H16046042510-1_R1_unpaired.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/220448_H16046042510-1_R2.fastq.gz /rds/general/user/sef17/home/msc_diss/data/gen/trimmed/220448_H16046042510-1_R2_unpaired.fastq.gz ILLUMINACLIP:/rds/general/user/sef17/home/msc_diss/ref/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36