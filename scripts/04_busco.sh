#!/bin/bash
source ../config/config.sh

busco \
-m transcriptome \
-i $TRANSCRIPTOME \
-o busco_result \
-l mollusca_odb10 \
-c $THREADS
