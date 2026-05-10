#!/bin/bash
# usage:
# bash scripts/04_busco.sh Ses/config.sh
# bash scripts/04_busco.sh Afang/config.sh
# bash scripts/04_busco.sh Lst/config.sh

source "$1"

busco \
-m transcriptome \
-i $TRANSCRIPTOME \
-o busco_result \
-l mollusca_odb10 \
-c $THREADS
