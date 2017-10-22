#!/bin/bash


while getopts ":m:" opt; do
  case ${opt} in
    m )
    master=$OPTARG
    ;;
    # s )
    # sub=$OPTARG
    # ;;
  esac
done

if [ ! -d "${master}" ] ; then
  mkdir $master
fi

# if [ ! -d "${sub}" ] ; then
#   mkdir $master/$sub
# fi

subDir=("meth" "meth_sym" "prop_meth" "cov_bw" "subset")

for i in "${subDir[@]}"
  do
    if [ ! -d "${i}" ] ; then
      mkdir ${master}/$(i)
    fi
  done