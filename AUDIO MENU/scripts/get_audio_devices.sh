#!/bin/bash

pactl list short sinks | while read -r line
do
    echo "$line" | awk '{ print $2 }'
done
