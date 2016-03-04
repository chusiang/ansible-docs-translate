#!/bin/bash

# Go zh-cn docs.
cd htmlout/

# convert to zh-tw.
for X in $(ls *.html); do
  opencc -i $X -o ../htmlout-zhtw/$X -c ../s2twp.json
done
