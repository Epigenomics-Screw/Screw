#!/bin/bash


DIRECTORY = ./

if [[ -d "${DIRECTORY}" && ! -L "${DIRECTORY}" ]] ; then
  echo "It's a bona-fide directory"
  read -p 'sub-directories: ' sD1 sD2 sD3 sD4
  for ((i=1;i<=4;i++))
  do
    if [[ -d "${sD$i}" && ! -L "${sD$i}" ]] ; then
      mkdir sD$i
    fi
  done
fi
