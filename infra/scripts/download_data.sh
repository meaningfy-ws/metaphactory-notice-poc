#!/bin/bash
# Downloads files specified as an URL in a file stored within the given directory
#
# Supports two types of list files:
# 1) *.txt: each line contains an URL
# 2) *.tsv (tab-separated): each line of the form `url<TAB>output-file-name`

if [ -z $1 ]; then
    echo "Input directory with lists of URLs to download not specified."
    exit 1
fi
if [ -z $2 ]; then
    echo "Output directory not specified."
    exit 1
fi
urls_lists_dir=$(readlink -f "$1")
echo 
mkdir -p "$2"
output_dir=$2

cd "$output_dir"
for file in $urls_lists_dir/*; do
    [ -e "$file" ] || continue
    if [[ $file =~ \.tsv$ ]]; then
        while IFS=$'\t' read -r url fname; do
            wget -O $fname $url
        done < "$file"
    else
        while read url; do
            wget $url
        done < "$file"
    fi
done
cd - &> /dev/null
