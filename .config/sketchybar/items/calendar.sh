#!/bin/bash

calendar=(
  icon=󰃭 
  icon.font="$FONT:Black:14.0"
  icon.color=$BLUE
  #icon.padding_left=10
  icon.padding_right=2
  icon.y_offset=1
  label.align=right
  label.padding_right=0
  update_freq=30
 # background.color=$BG0
  #background.height=20
  #blur_radius=15
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke \
