#!/bin/bash
source ../config/config.sh

mkdir -p $FASTQC_DIR

fastqc --nogroup -o $FASTQC_DIR $READ1 $READ2
