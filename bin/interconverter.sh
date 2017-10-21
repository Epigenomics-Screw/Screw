#!/bin/bash


while getopts ":d:i:f:" opt; do
  case ${opt} in
	d )
	outdir=$OPTARG
	;;
	i )
	infile=$OPTARG
	;;
	f )
	format=$OPTARG
	;;
  esac
done

outdir=${outdir:-.}

## target format: <chromosome> <position> <strand> <context> <meth_rate> <total>
case $format in
	farlik2016 )
	awk -F "\t" '{
	print $1, $2, "*", "CpG", $3/($3+$4), ($3+$4);
	}' $infile > $outdir/$(basename $infile).meth
	;;

	farlik2015|smallwood2014 )
	## format: <chromosome> <position> <strand> <count methylated> 
	##         <count non-methylated> <C-context> <trinucleotide context> 
	awk -F "\t" '{
    if ($6 == "CG") {
      print $1, $2, $3, "CpG", ($4+$5 > 0 ? $4/($4+$5) : 0), $4+$5;
	}}' $infile > $outdir/$(basename $infile).meth
	;;

	farlik2013 )
	awk -F "\t" '{
	if($6 == "CG"){
	  print $1, $2, $3, "CpG", $4/($4+$5), ($4+$5);
	}
	}' $infile > $outdir/$(basename $infile).meth
	;;

	guo2013 )
	## format: <Chr> <Pos> <Ref> <Chain> <Total> <Met> <UnMet> <MetRate>
	##         <Ref_context> <Type>
	awk -F "\t" 'NR>1 {
	print $1, $2, "*", $10, $8, $5;
	}' $infile > $outdir/$(basename $infile).meth
	;;

	* )
	echo "That format isn't recognised. Currently recognised are farlik2016, farlik2015, farlik2013, guo2013, smallwood2014"
	;;
esac

