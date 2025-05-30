#!/bin/bash

win=$(yabai -m query --windows --window last | jq '.id')

while : ; do
    yabai -m window $win --focus stack.next &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done
