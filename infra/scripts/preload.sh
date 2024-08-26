#!/bin/bash -x
importrdf=/opt/graphdb/dist/bin/importrdf

data_dir="$1"
repo_cfg="$2"

$importrdf preload --force --recursive -q /tmp -c "$repo_cfg" "$data_dir"
