#!/bin/bash

THREADS=8
SPECIES=Ses #Acanthosepion esculentum

BASE_DIR=~/data/Ses_bulk_RNA-seq_2nd-arm

RAW_DIR=$BASE_DIR/raw
TRIM_DIR=$BASE_DIR/trimmed
FASTQC_DIR=$BASE_DIR/fastqc
ASSEMBLY_DIR=$BASE_DIR/assembly
SALMON_DIR=$BASE_DIR/salmon

ADAPTER=$BASE_DIR/adapter_Ses.fa

TRINITY_OUT=$ASSEMBLY_DIR/trinity

# original Trinity assembly
TRINITY_FASTA=$TRINITY_OUT/Trinity.fasta

# cd-hit output
CDHIT_FASTA=$ASSEMBLY_DIR/Trinity_cdhit.fa

# downstream transcriptome
TRANSCRIPTOME=$CDHIT_FASTA

SALMON_INDEX=$SALMON_DIR/index

METADATA_DIR=Ses/metadata
