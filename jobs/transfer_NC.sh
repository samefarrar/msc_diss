#! /bin/sh
#PBS -N transfer_to_ephem
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=4:mem=16gb

mv /rds/general/user/sef17/home/msc_diss/data/orig/* /rds/general/user/sef17/ephemeral