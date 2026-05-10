#!/bin/bash
# usage:
# bash 03_assembly.sh ../Ses/config.sh
# bash 03_assembly.sh ../Afang/config.sh
# bash 03_assembly.sh ../Lst/config.sh

source "$1"

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
