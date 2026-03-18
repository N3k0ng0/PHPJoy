#!/bin/bash

mkdir -p results

printf "%s\n" 1 2 3 | xargs -n1 -P2 -I{} \
  python3 main.py -vt {} -o "results/vt{}" -1 example
