#!/bin/bash

# usage:
#   ./export.sh file1.svg file2.svg ...

# output directory prefix
outDir=png
# must have largest first
sizes="512 256 64 16"
# generate images `overscale` times bigger to remove filter artefacts
overscale=2

set -e

largest_size=$(echo "$sizes" | awk '{print $1;}')
overscale_size=$(($largest_size * $overscale))

for inFile in "$@"; do
    basename=$(basename -- "$inFile")
    tmpFile=tmp_${basename%.svg}.png

    inkscape -w $overscale_size -h $overscale_size -o $tmpFile $inFile

    for size in $sizes; do
        mkdir -p $outDir$size

        outFile=$outDir$size/${basename%.svg}.png

        convert $tmpFile -resize ${size}x $outFile
    done

    rm $tmpFile
done