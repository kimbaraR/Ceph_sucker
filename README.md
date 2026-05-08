# Ceph_sucker
Codes and R scripts used during the analyses of transcriptome of cephalopod arms and suckers.

## Environment

This pipeline was originally executed on the supercomputer in National Institute of Genetics, Japan using Singularity containers.

However, all commands are written in a system-independent format and can be run with standard installations of:

- FastQC
- Trimmomatic
- Trinity
- BUSCO
- Salmon
- R (DESeq2, tximport)

Singularity usage is optional and described in `environment/singularity_notes.txt`.
