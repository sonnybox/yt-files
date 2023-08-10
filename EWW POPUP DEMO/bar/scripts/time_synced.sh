#!/bin/bash
# Print initial time
date '+%a %m/%d %I:%M %p'
s=$(date +%S)
sleep $((60 - s))

while true
do
    # Print current time
    date '+%a %m/%d %I:%M %p'

    # Sleep until the next full minute
    sleep 60
done
