#!/bin/bash

# Runs all python scripts in the current directory that end with _test.py
# unless the test is specified in $blacklist.

blacklist="cron_servlet_test.py"

all_tests=`ls *_test.py`
failed_tests=""

echo Running `wc -l <<< "$all_tests"` tests

for f in $all_tests; do
   if ! grep $f <<< $blacklist > /dev/null; then
       $f 2> /dev/null
   fi

   if [ $? -eq 0 ]; then
      echo -n .
   else
      echo -n E
      failed_tests="$failed_tests $f"
   fi
done

echo -ne '\n\n'
sed 's/ /\n/g' <<< $failed_tests | xargs | sed 's/^\(\w\)/[E] \1/g'
