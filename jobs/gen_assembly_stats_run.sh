echo -n "~/msc_diss/ref/assembly_stats/assembly_stats -t" >> /rds/general/user/sef17/home/msc_diss/jobs/ASSEMBLY_stats.sh
cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies
for d in *_spades/; do
    ISOLATE=${f%_spades/};
    echo -n " /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/${d}scaffolds.fasta" >> /rds/general/user/sef17/home/msc_diss/jobs/ASSEMBLY_stats.sh
done