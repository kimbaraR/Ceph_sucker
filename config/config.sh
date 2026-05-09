#!/bin/bash

# Threads
THREADS=8

# Directories
BASE_DIR=~/project
RAW_DIR=$BASE_DIR/raw
TRIM_DIR=$BASE_DIR/trimmed
FASTQC_DIR=$BASE_DIR/fastqc
ASSEMBLY_DIR=$BASE_DIR/assembly
SALMON_DIR=$BASE_DIR/salmon

# Files
ADAPTER=$BASE_DIR/adapters.fa

# Trinity
TRINITY_OUT=$ASSEMBLY_DIR/trinity_out
TRANSCRIPTOME=$TRINITY_OUT/Trinity.fasta

# Salmon
SALMON_INDEX=$SALMON_DIR/index
