#!/bin/bash


while getopts ":d:f:" opt; do
  case ${opt} in
    d )
    outdir=$OPTARG
    # outdir=${OPTARG}/subset
    ;;
    f )
    infiles+=($OPTARG)
    # indir=${OPTARG}/subset
    ;;
  esac
done

outdir=${outdir:-$TMPDIR}

# cd ${indir};
# for i in *.sym; do
for i in ${infiles[@]}; do
  printf "%s\t" $(basename ${i} .meth.sym);
done
echo;

# for i in *.sym; do
for i in ${infiles[@]}; do
  awk '{print $1 ":" $2 "\t" $5}' ${i} | sort -k 1b,1 > $outdir/${i}.tojoin;
  printf "%s\t" $(basename ${i} .meth.sym);
  for j in *.sym; do
    awk '{print $1 ":" $2 "\t" $5}' ${j} | sort -k 1b,1 > $outdir/${j}.tojoin;
    join $outdir/${i}.tojoin $outdir/${j}.tojoin > $outdir/temp;
    x=$(awk 'BEGIN{distance=0}{distance+=($3-$2)^2;}END{print sqrt(distance)}' $outdir/temp);
    printf "%s\t" ${x};
  done
  printf "\n";
done;

rm $outdir/*.tojoin;
rm $outdir/temp;
