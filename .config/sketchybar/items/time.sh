#!/bin/bash

time=(
  #icon=
  #icon.font="$FONT:Bold:18.0"
  #icon.color=$BLACK
  #icon.y_offset=1.5
  #icon.padding_left=5
  label.font="$FONT:Bold:12.0"
  label.color=$WHITE
  #label.padding_right=10
  label.padding_left=0
  label.y_offset=1.5
  label.align=right
  label.drawing=on
  #background.color=$YELLOW
  #background.height=20
  #blur_radius=15
  update_freq=1
  padding_right=5
  #padding_left=5
  script="$PLUGIN_DIR/time.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item time right       \
           --set time "${time[@]}" \
           --subscribe time
