#!/bin/bash

function file_length {
   wc -l $1 | grep -oP '^\s*\d+'
}

function print_max {
   # Print out the contents of file $1. If more than $2 lines will be
   # printed, print a condensed form instead.
   if [ `file_length $1` -gt $2 ]; then
      head $1
      echo ...
      tail $1
   else
      cat $1
   fi
}

# Get two files to store outputs in.
TMP_OUTPUT_FILE=`tempfile`
DIFF_FILE=`tempfile`

# Run the Python script.
python get_samples_output.py &> $TMP_OUTPUT_FILE

# Show the output of running the script if the command failed and exit.
if [ ${PIPESTATUS[0]} -ne 0 ]; then
   cat $TMP_OUTPUT_FILE
   echo `file_length $TMP_OUTPUT_FILE` line output file stored in $TMP_OUTPUT_FILE
   exit 1
fi

# Compare our output with the reference output.
diff samples.out $TMP_OUTPUT_FILE > $DIFF_FILE

# Show the diff if the files were not the same.
if [ $? -ne 0 ]; then
   print_max $DIFF_FILE 20
   echo `file_length $DIFF_FILE` line diff stored in $DIFF_FILE
fi

# Remove the temporary output file.
rm $TMP_OUTPUT_FILE
