for d in *_spades/; do
    echo -e "${d%_spades/}\t/rds/general/user/sef17/home/msc_diss/data/gen/assemblies/${d}contigs.fasta" >> all_12f.txt
done