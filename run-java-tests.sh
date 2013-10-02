#!/bin/bash

if [ ! $1 ]; then
   echo "Usage: run.sh <java-program>"
   exit
fi

for f in tests/*
do
   echo INPUT
   cat $f | sed "s/^/  /g"
   echo OUTPUT
   java -cp `pwd` $1 < $f | sed "s/^/  /g"
   echo
done
