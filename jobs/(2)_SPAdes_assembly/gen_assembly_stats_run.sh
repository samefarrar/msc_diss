echo -n "~/msc_diss/ref/assembly-stats/assembly-stats -t" >> /rds/general/user/sef17/home/msc_diss/jobs/ASSEMBLY_stats.sh
cd /rds/general/user/sef17/home/msc_diss/data/gen/assemblies
for d in *_spades/; do
    ISOLATE=${f%_spades/};
    echo -n " /rds/general/user/sef17/home/msc_diss/data/gen/assemblies/${d}scaffolds.fasta" >> /rds/general/user/sef17/home/msc_diss/jobs/ASSEMBLY_stats.sh
done
echo -n " >> /rds/general/user/sef17/home/msc_diss/result/assembly_stats.txt" >> /rds/general/user/sef17/home/msc_diss/jobs/ASSEMBLY_stats.sh