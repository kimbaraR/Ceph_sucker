#!/bin/bash

# Example DEG filtering
awk -F',' '$7 < 0.05 {print $1}' DESeq2_D_vs_P.csv > DEG_ids.txt

seqkit grep -f DEG_ids.txt Trinity.fasta > DEG_sequences.fa
