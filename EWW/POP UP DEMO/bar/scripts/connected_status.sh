#!/bin/bash

prev_status=""

while true
do
    if ping -c 1 8.8.8.8 &> /dev/null; then
        cur_status=" "
    else
        cur_status=" "
    fi

    if [[ "$cur_status" != "$prev_status" ]]; then
        echo "$cur_status"
        prev_status="$cur_status"
    fi

    sleep 30
done

