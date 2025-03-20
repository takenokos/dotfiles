#!/bin/bash

front_app=(
  icon.font="sketchybar-app-font:Regular:14.0"
  icon.padding_left=10
  label.font="$FONT:Italic:14.0"
  label.padding_right=10
  display=active
  shadow=on
  background.color=$BG2
  blur_radius=15
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app center         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
