#!/bin/bash
# Note that due to a severe `preload` limitation that doesn't support named
# graphs the importing process utilizes both `preload` and REST API.
# The `preload` is used as it has the best possible performance.

set -euo pipefail

SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
import_dir="$1"
data_dir="$2"
repo_cfg="$3"
import_dir_preload="${import_dir}/default"
import_dir_rest="${import_dir}/named_graph"
data_dir_preload="${data_dir}/preload"
data_dir_rest="${data_dir}/rest"

importrdf=/opt/graphdb/dist/bin/importrdf
graphdb=/opt/graphdb/dist/bin/graphdb

mkdir -p "$data_dir_preload" "$data_dir_rest"

# 1. download data
$SCRIPT_DIR/download_data.sh "$import_dir_preload" "$data_dir_preload"
$SCRIPT_DIR/download_data.sh "$import_dir_rest" "$data_dir_rest"

# 2. load notice data into default graph using preload
$SCRIPT_DIR/preload.sh "$data_dir_preload" "$repo_cfg" 

# 3. start graphdb service
$graphdb &
while ! curl -sSf http://localhost:7200/rest/repositories > /dev/null;
do 
    echo "Waiting for GraphDB...";
    sleep 1;
done;
echo "GraphDB started";

# 4. import vocabularies, each as a separated named graph
$SCRIPT_DIR/rest_import.sh "$data_dir_rest" "$repo_cfg" 

# 5. #TODO execute SPARQL query creating indexes 
$SCRIPT_DIR/create_indexes.sh

# 6. remove downloaded files
cd "$data_dir" && rm -rf *
