#!/bin/bash
# usage:
# bash scripts/09_extract_deg_fasta.sh Ses/config.sh

source "$1"

mkdir -p Ses/deg_analysis
mkdir -p Ses/deg_analysis/fasta

##################################################
# positional DEG overlap (PMD)
##################################################

# Distal > Middle AND Distal > Proximal
grep -Fxf \
Ses/deseq2/pmd/distal_DM_genes.txt \
Ses/deseq2/pmd/distal_DP_genes.txt \
> Ses/deg_analysis/distal_PMD_genes.txt

# Middle > Distal AND Middle > Proximal
grep -Fxf \
Ses/deseq2/pmd/middle_DM_genes.txt \
Ses/deseq2/pmd/middle_MP_genes.txt \
> Ses/deg_analysis/middle_PMD_genes.txt

# Proximal > Distal AND Proximal > Middle
grep -Fxf \
Ses/deseq2/pmd/proximal_DP_genes.txt \
Ses/deseq2/pmd/proximal_MP_genes.txt \
> Ses/deg_analysis/proximal_PMD_genes.txt

##################################################
# extract fasta
##################################################

seqkit grep \
-f Ses/deg_analysis/distal_PMD_genes.txt \
$TRANSCRIPTOME \
-o Ses/deg_analysis/fasta/Distal.fa

seqkit grep \
-f Ses/deg_analysis/middle_PMD_genes.txt \
$TRANSCRIPTOME \
-o Ses/deg_analysis/fasta/Middle.fa

seqkit grep \
-f Ses/deg_analysis/proximal_PMD_genes.txt \
$TRANSCRIPTOME \
-o Ses/deg_analysis/fasta/Proximal.fa

##################################################
# overlap between Distal and Oral
##################################################

mkdir -p Ses/deg_analysis/overlap

# distal & oral
grep -Fxf \
Ses/deg_analysis/distal_PMD_genes.txt \
Ses/deseq2/oab/oral_genes.txt \
> Ses/deg_analysis/overlap/distal_oral_genes.txt

seqkit grep \
-f Ses/deg_analysis/overlap/distal_oral_genes.txt \
$TRANSCRIPTOME \
-o Ses/deg_analysis/overlap/distal_oral.fa
