#! /bin/sh
#PBS -N poppunk_12f
#PBS -o poppunk_12f.o
#PBS -e poppunk_12f.e
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=48gb

module load anaconda3/personal

source activate poppunk

cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies

# create the database
poppunk --create-db --r-files input/poppunk_12f.txt --output all_refine --threads 8 --overwrite --min-k 15 --max-k 29 --k-step 3 --plot-fit 5 --length-range 1900000 2500000
# fit to a bayesian gaussian mixture model
poppunk --fit-model bgmm --distances 12f_refine/12f_refine.dists --output 12f_refine --ref-db 12f_refine --threads 8 --overwrite --min-k 15 --max-k 29 --k-step 3 --K 5 --length-range 1900000 2500000
# optimise the network score from a model already fitted by bgmm
poppunk --fit-model refine --distances 12f_refine/12f_refine.dists --output 12f_refine --ref-db 12f_refine --threads 8 --overwrite --min-k 15 --max-k 29 --k-step 3 --K 5
# visulise the poppunk clustering results for the use of microreact 
poppunk_visualise --ref-db all_refine --output all_refine --microreact
" > poppunk_12f.sh
