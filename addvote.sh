#! /bin/bash

# Add a vote to a movie.
# Usage: ./addpoll.sh <poll id> <movie name> <voter name>
# All arguments should be enclosed in single quotes.

# read input
pollid=$1
moviename=$2
votername=$3

pollpath="polls/${pollid}" # path to poll in question

# Record a vote by <voter name> for <movie name>, but only if they haven't voted already
jq --arg movieName "$moviename" --arg voterName "$votername"                                                                                     \
    '[.[] | .votes += if .name == $movieName and (.votes | any(. == $voterName) | not) then [$voterName] else null end]' ${pollpath}/movies.json \
    > ${pollpath}/tmp.json

cat ${pollpath}/tmp.json > ${pollpath}/movies.json
rm ${pollpath}/tmp.json
