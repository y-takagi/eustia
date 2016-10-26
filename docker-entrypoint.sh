#!/bin/bash
set -e

projects=(`ls -d -- projects/*/`)

for project in ${projects[@]}; do
    digdag push `basename $project` --project $project -e $DIGDAG_ENDPOINT
done

exec "$@"
