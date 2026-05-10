#!/bin/bash

# usage:
# bash scripts/05_cdhit.sh Ses/config.sh
# bash scripts/05_cdhit.sh Afang/config.sh
# bash scripts/05_cdhit.sh Lst/config.sh

source "$1"

cd-hit-est \
-i $TRINITY_FASTA \
-o $CDHIT_FASTA \
-c 0.9 \
-n 8 \
-T $THREADS \
-M 64000
