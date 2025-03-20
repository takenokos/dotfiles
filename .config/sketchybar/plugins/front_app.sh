#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --animate sin 15 --set $NAME y_offset=70            \
             --animate sin 10 --set $NAME y_offset=7            \
             --animate sin 15 --set $NAME y_offset=0
       
  sleep 0.15
  sketchybar --set $NAME label="$INFO" icon="$($CONFIG_DIR/plugins/icon_map.sh "$INFO")"
fi
