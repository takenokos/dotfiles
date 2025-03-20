#!/bin/bash

update_media() {
  STATE="$(echo "$INFO" | jq -r '.state')"

  if [ "$STATE" = "playing" ]; then
    APP=$(echo "$INFO" | jq -r '.app')
    MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
    ICON="$($CONFIG_DIR/plugins/icon_map.sh "$APP")"
    sketchybar --set $NAME icon.background.image="$ICON" label="$MEDIA" drawing=on background.drawing=on
  else
    sketchybar --set $NAME drawing=off
  fi
}

case "$SENDER" in
  "media_change") update_media
  ;;
esac
