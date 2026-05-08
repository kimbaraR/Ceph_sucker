#!/bin/bash
source ../config/config.sh

mkdir -p $FASTQC_DIR

for f in $RAW_DIR/*_1.fq.gz; do
    fastqc --nogroup -o $FASTQC_DIR $f ${f/_1/_2}
done
