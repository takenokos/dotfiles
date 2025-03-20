media=(
  drawing=off
  icon.background.drawing=on
  icon.background.image=media.artwork
  icon.background.image.corner_radius=10
  icon.background.image.scale=0.75
  icon.background.image.padding_left=3
  label.padding_right=10
  label.max_chars=20
  script="$PLUGIN_DIR/media.sh"
  scroll_texts=on
  updates=on
  background.color=$BG0
  background.drawing=off
)

sketchybar --add item media right \
           --set media "${media[@]}" \
           --subscribe media media_change
