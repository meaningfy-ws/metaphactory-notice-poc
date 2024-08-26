#!/bin/bash -x
# Imports every file from the given directory into the predefined repo.
# Each file gets imported as a new named graph with a name derived from a file
# name.

data_dir="$1"
repo_id="notices"  # FIXME can be extracted from the passed repo config file instead


for file in $data_dir/*; do
    [ -e "$file" ] || continue
    filename=$(basename $file)
    graph_name=${filename%.*}
    
    curl -X 'PUT' \
        'http://localhost:7200/repositories/'$repo_id'/statements?context=%3Chttp%3A%2F%2F'$graph_name'%3E' \
        -H 'accept: */*' \
        -H 'Content-Type: application/rdf+xml' \
        --data-binary "@${file}"
done
