#!/bin/bash


while getopts ":d:i:f:" opt; do
  case ${opt} in
    d )
    outdir=${OPTARG}/meth
    ;;
    i )
    infile=$OPTARG
    ;;
    f )
    format=$OPTARG
    ;;
  esac
done

case $format in
	farlik2016 )
	awk -F "\t" '{
	print $1, $2, "*", "CpG", $3/($3+$4), ($3+$4);
	}' $infile > $outdir/$(basename $infile).meth
	;;
	farlik2013 )
	awk -F "\t" '{
    if($6 == "CG"){
      print $1, $2, $3, "CpG", $4/($4+$5), ($4+$5);
    }
	}' $infile > $outdir/$(basename $infile).meth
	;;
	* )
	echo "That format isn't recognised. Currently recognised are farlik2016, farlik2013"
	;;
esac

