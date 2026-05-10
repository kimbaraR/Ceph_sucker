#!/bin/bash

source "$1"

ASSEMBLY_LIST="$2"
ASSEMBLY_OUTPUT="$3"

mkdir -p "$ASSEMBLY_DIR"

LEFT=$(while read sample; do
    echo -n "$TRIM_DIR/${sample}_R1P.fq.gz,"
done < "$ASSEMBLY_LIST" | sed 's/,$//')

RIGHT=$(while read sample; do
    echo -n "$TRIM_DIR/${sample}_R2P.fq.gz,"
done < "$ASSEMBLY_LIST" | sed 's/,$//')

Trinity \
--seqType fq \
--left "$LEFT" \
--right "$RIGHT" \
--CPU "$THREADS" \
--max_memory 128G \
--output "$ASSEMBLY_OUTPUT"

# usage (Ses: oral-aboral assembly)
# bash scripts/03_assembly.sh \
# Ses/config.sh \
# Ses/metadata/assembly_ab_o.txt \
# ~/data/Ses_bulk_RNA-seq_2nd-arm/assembly/Trinity_Ses2nd_oab

# usage (Afang)
# bash scripts/03_assembly.sh \
# Afang/config.sh \
# Afang/metadata/sample_list.txt \
# ~/Af_rnaseq/assembly/trinity_out
