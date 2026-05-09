#!/bin/bash

THREADS=12
SPECIES=Ses # Acanthosepion esculentum

BASE_DIR=~/data/Ses_bulk_RNA-seq_2nd-arm

RAW_DIR=$BASE_DIR/raw
TRIM_DIR=$BASE_DIR/trimmed
FASTQC_DIR=$BASE_DIR/fastqc
ASSEMBLY_DIR=$BASE_DIR/assembly
SALMON_DIR=$BASE_DIR/salmon
METADATA_DIR=Ses/metadata
ADAPTER=$BASE_DIR/adapter_Ses.fa

# Assembly outputs
TRINITY_ABO=$ASSEMBLY_DIR/Trinity_Ses2nd_oab
TRINITY_PMD=$ASSEMBLY_DIR/Trinity_Ses2nd_pmd

# downstream transcriptome
TRINITY_FASTA=$TRINITY_PMD/Trinity.fasta

# cd-hit output
CDHIT_FASTA=$ASSEMBLY_DIR/Trinity_Ses2nd_pmd_cdhit.fa

# downstream reference
TRANSCRIPTOME=$CDHIT_FASTA

SALMON_INDEX=$SALMON_DIR/index


