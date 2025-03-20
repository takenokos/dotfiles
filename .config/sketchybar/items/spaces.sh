#!/bin/bash

source "$CONFIG_DIR/colors.sh"
SPACE_ICONS=("1." "2." "3." "4." "5." "6." "7." "8." "9." "10." "11." "12.")
# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

length=${#SPACE_ICONS[@]}

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  PD_LEFT=5
  PD_RIGHT=5

  space=(
    space=$sid
    padding_left=$PD_LEFT
    padding_right=$PD_RIGHT
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=8
    icon.padding_right=-6
    icon.color=${COLORS_SPACE[i]}
    icon.highlight_color=$BLACK
    icon.y_offset=1
    label.padding_right=16
    label.color=${COLORS_SPACE[i]}
    label.highlight_color=$BLACK
    label.font="sketchybar-app-font:Regular:14.0"
    label.y_offset=-1
    background.corner_radius=10
    background.height=20
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked space_windows_change
done

# Space bracket
sketchybar --add bracket spaces '/space\..*/'                        \
           --set         spaces   background.color=$BG2      \
                                  blur_radius=15              \
                                  shadow=on
