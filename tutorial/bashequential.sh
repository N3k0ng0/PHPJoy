#!/bin/bash

mkdir -p results

# List the vuln types you want to run
VULN_TYPES=(1 2 3)

for vt in "${VULN_TYPES[@]}"; do
  echo "Running vuln type $vt"
  python script.py -vt "$vt" -o "results/vt${vt}" -1 example
done
