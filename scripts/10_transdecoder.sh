#!/bin/bash
# usage:
# bash scripts/10_transdecoder.sh Ses/config.sh　Ses/deg_analysis/overlap/distal_oral.fa

source "$1"

FASTA="$2"

TransDecoder.LongOrfs \
-G universal \
-m 60 \
-t $FASTA

TransDecoder.Predict \
-t $FASTA
