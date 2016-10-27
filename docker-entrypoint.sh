#!/bin/bash
set -e

projects=(`ls -d -- digdag_projects/*/`)

for project in ${projects[@]}; do
    digdag push `basename $project` --project $project -e $DIGDAG_ENDPOINT
done

exec "$@"
