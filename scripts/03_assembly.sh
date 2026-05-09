#!/bin/bash
source ../config/config.sh

mkdir -p $ASSEMBLY_DIR

LEFT=$(ls $TRIM_DIR/*_R1P.fq.gz | paste -sd ",")
RIGHT=$(ls $TRIM_DIR/*_R2P.fq.gz | paste -sd ",")

Trinity \
--seqType fq \
--left $LEFT \
--right $RIGHT \
--CPU $THREADS \
--max_memory 50G \
--output $TRINITY_OUT
