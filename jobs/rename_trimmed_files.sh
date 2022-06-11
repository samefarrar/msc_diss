cd /rds/general/user/sef17/home/msc_diss/data/gen/trimmed
for f in *_1.fastq.gz; do
    ISOLATE=${f%_1.fastq.gz}
    mv $f ${ISOLATE}_R1.fastq.gz
    mv ${ISOLATE}_2.fastq.gz ${ISOLATE}_R2.fastq.gz
done