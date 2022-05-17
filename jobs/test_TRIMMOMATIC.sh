#! /bin/sh
#PBS -N trimmomatic_test
#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=4:mem=16gb

module load anaconda3/personal
source activate trim039

java -jar ../ref/Trimmomatic-0.39/dist/jar/trimmomatic-0.39.jar PE -threads 4 -phred33 ../data/orig/12F_epidemiology/fastqs/975747_1.fastq.gz