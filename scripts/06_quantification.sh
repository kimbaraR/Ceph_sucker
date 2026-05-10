#!/bin/bash
# usage:
# bash scripts/06_quantification.sh Ses/config.sh

source "$1"

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
done < $METADATA_DIR/sample_list.txt
