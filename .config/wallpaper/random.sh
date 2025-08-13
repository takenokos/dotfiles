#!/usr/bin/env bash

wallpapers_dir="$HOME/.config/wallpaper"
sleep_time=3600

while true; do
  current_img=$(swww query | grep 'currently displaying:' | sed -n 's/.*image: //p')
  if [[ -n "$cuttrnt_img" ]]; then
    imgs=($(fd -u --type f --exclude "$(basename "$current_img")" --exclude '*.sh' '' "$wallpapers_dir"))
  else
    imgs=($(fd -u --type f --exclude '*.sh' '' "$wallpapers_dir"))
  fi
  if [[ ${#imgs[@]} -eq 0 ]]; then
    sleep 00
    continue
  fi
  img="${imgs[RANDOM % ${#imgs[@]}]}"
  swww img $img --transition-type random
  sleep $sleep_time
done
