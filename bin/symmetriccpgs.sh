#!/bin/bash

while getopts ":d:i:" opt; do
  case ${opt} in
    d )
	outdir=$OPTARG
    # outdir=${OPTARG}/meth_sym
    ;;
    i )
    infile=$OPTARG
    ;;
  esac
done

symmetric-cpgs $infile > $outdir/$(basename $infile).sym


