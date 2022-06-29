#! /bin/sh
#PBS -o logs/ska32.run.o
#PBS -e logs/ska32.run.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -N ska_32

module load anaconda3/personal
echo "Anaconda Loaded"
source activate gubbins
echo "Gubbins Profile Loaded"
generate_ska_alignment.py --reference /rds/general/user/sef17/home/msc_diss/ref/gps_refs/GPSC32_reference.fasta --fasta /rds/general/user/sef17/home/msc_diss/result/cluster_lists/GPSC_32.list --out ~/msc_diss/result/ska_alignment/GPSC_32.aln
echo "Alignment generated"
source activate gubbins
cd ~/msc_diss/result/ska_alignment
run_gubbins.py --prefix gubbins_32 /rds/general/user/sef17/home/msc_diss/result/ska_alignment/GPSC_32.aln
echo "Gubbins Complete"