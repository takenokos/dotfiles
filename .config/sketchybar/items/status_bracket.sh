status_bracket=(
  shadow=on
  background.height=30
  background.color=$BG2
  background.border_color=$BACKGROUND_2
  blur_radius=30
)

sketchybar --add bracket status time calendar brew github.bell wifi volume_icon battery\
           --set status "${status_bracket[@]}"
