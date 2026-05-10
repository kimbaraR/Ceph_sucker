#!/bin/bash
# usage:
# bash 01_qc.sh ../Ses/config.sh
# bash 01_qc.sh ../Afang/config.sh
# bash 01_qc.sh ../Lst/config.sh

source "$1"

mkdir -p $FASTQC_DIR

for f in $RAW_DIR/*_1.fq.gz; do
    fastqc --nogroup -o $FASTQC_DIR $f ${f/_1/_2}
done
