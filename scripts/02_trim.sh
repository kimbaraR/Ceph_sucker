#!/bin/bash
source ../config/config.sh

mkdir -p $TRIM_DIR

while read sample; do
    trimmomatic PE -threads $THREADS \
    $RAW_DIR/${sample}_1.fq.gz \
    $RAW_DIR/${sample}_2.fq.gz \
    $TRIM_DIR/${sample}_R1P.fq.gz \
    $TRIM_DIR/${sample}_R1U.fq.gz \
    $TRIM_DIR/${sample}_R2P.fq.gz \
    $TRIM_DIR/${sample}_R2U.fq.gz \
    ILLUMINACLIP:$ADAPTER:2:30:10 \
    LEADING:20 TRAILING:20 \
    SLIDINGWINDOW:4:15 MINLEN:30
done < ../metadata/sample_list.txt
