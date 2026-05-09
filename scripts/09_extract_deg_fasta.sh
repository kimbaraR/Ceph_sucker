#!/bin/bash
source $1

mkdir -p ../deg_analysis
mkdir -p ../deg_analysis/fasta

##################################################
# positional DEG overlap (PMD)
##################################################

# Distal > Middle AND Distal > Proximal
grep -Fxf \
../deseq2/pmd/distal_DM_genes.txt \
../deseq2/pmd/distal_DP_genes.txt \
> ../deg_analysis/distal_PMD_genes.txt

# Middle > Distal AND Middle > Proximal
grep -Fxf \
../deseq2/pmd/middle_DM_genes.txt \
../deseq2/pmd/middle_MP_genes.txt \
> ../deg_analysis/middle_PMD_genes.txt

# Proximal > Distal AND Proximal > Middle
grep -Fxf \
../deseq2/pmd/proximal_DP_genes.txt \
../deseq2/pmd/proximal_MP_genes.txt \
> ../deg_analysis/proximal_PMD_genes.txt

##################################################
# extract fasta
##################################################

seqkit grep \
-f ../deg_analysis/distal_PMD_genes.txt \
$TRANSCRIPTOME \
-o ../deg_analysis/fasta/Distal.fa

seqkit grep \
-f ../deg_analysis/middle_PMD_genes.txt \
$TRANSCRIPTOME \
-o ../deg_analysis/fasta/Middle.fa

seqkit grep \
-f ../deg_analysis/proximal_PMD_genes.txt \
$TRANSCRIPTOME \
-o ../deg_analysis/fasta/Proximal.fa
