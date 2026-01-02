#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide a sink name."
    exit 1
fi

SINK_NAME="$1"

pactl list short sinks | grep "$SINK_NAME" | while read -r line
do
    SINK_ID=$(echo "$line" | awk '{ print $1 }')
    pactl set-default-sink "$SINK_ID"
done
