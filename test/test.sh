#!/usr/bin/env bash
for i in examples/*; do
  echo "---------------------------------------------"
  echo $i
  time ./bin/run < $i
  echo "---------------------------------------------"
done
