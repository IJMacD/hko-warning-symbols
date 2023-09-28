#!/bin/bash

# usage:
#   ./export-plain-svg.sh file1.svg file2.svg ...

# output directory prefix
outDir=svg

set -e

mkdir -p $outDir

for inFile in "$@"; do
    basename=$(basename -- "$inFile")
    outFile=$outDir/$basename

    inkscape --export-text-to-path --export-plain-svg -o $outFile $inFile
done