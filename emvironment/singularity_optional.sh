#!/bin/bash

# Optional Singularity wrappers used on the NIG supercomputer

FASTQC="singularity exec fastqc.sif fastqc"

TRIMMOMATIC="singularity exec trimmomatic.sif trimmomatic"

TRINITY="singularity exec trinity.sif Trinity"

BUSCO="singularity exec busco.sif busco"

SALMON="singularity exec salmon.sif salmon"
