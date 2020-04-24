#! /bin/bash

# Add a new movie to a poll.
# Usage: ./addmovie.sh <pollid> <newmovie>
# 2nd argument should be enclosed in single quotes to ensure it's parsed correctly.

# read input
pollid=$1
newmovie=$2

# path to poll in question
pollpath="polls/${pollid}"

# add the new movie to the poll
jq --argjson newMovie "$newmovie" '. + [$newMovie]' ${pollpath}/movies.json > ${pollpath}/tmp.json
cat ${pollpath}/tmp.json > ${pollpath}/movies.json
rm ${pollpath}/tmp.json
