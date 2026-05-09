#!/bin/bash
source ../config/config.sh

mkdir -p $SALMON_DIR

salmon index \
-t $TRANSCRIPTOME \
-i $SALMON_INDEX \
-k 31

while read sample; do
    salmon quant \
    -i $SALMON_INDEX \
    -l A \
    -1 $TRIM_DIR/${sample}_R1P.fq.gz \
    -2 $TRIM_DIR/${sample}_R2P.fq.gz \
    -p $THREADS \
    -o $SALMON_DIR/${sample}
done < ../metadata/sample_list.txt
