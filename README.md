# Ceph_sucker
Codes and R scripts used during the analyses of transcriptome of cephalopod arms and suckers.

## Environment

This pipeline was originally executed on the supercomputer in National Institute of Genetics (Japan) using Singularity containers.
It was designed to be system-independent and can be run with standard bioinformatics environments.

Required software
- FastQC
- Trimmomatic
- Trinity
- BUSCO
- Salmon
- seqkit
- R (DESeq2, tximport)
- TransDecoder

Singularity usage is optional and described in `environment/singularity_notes.txt`.

## Configuration system

Each species has an independent configuration file:
Ses/config.sh
Afang/config.sh
Lst/config.sh

Scripts are designed to be reusable across species by passing the config file
