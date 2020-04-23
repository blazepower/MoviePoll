#! /bin/bash

# Setup a new poll.

# Create a unique ID for the poll
pollid=$(echo $RANDOM | md5sum | awk '{print $1}')

# Create the polls/ directory, if it doesn't already exist
mkdir -p polls/

# Create a directory for the new poll, and go there for further setup
mkdir -p polls/${pollid}
cd polls/${pollid}

# Create a file containing an empty JSON array, which will store the movies
echo $'[\n]' > movies.json

# Output the poll id to stdout so that the user can be redirected to the poll
echo $pollid
