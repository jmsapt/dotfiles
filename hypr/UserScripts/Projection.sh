#!/bin/bash

# Toggle mirror/extend projections
# monitor=,preferred,auto,1,mirror,eDP-1
# monitor=,preferred,auto,1 #,mirror,eDP-1

# refresh wallpaper on change
refresh() {
  IMAGE_PATH=$(swww query | grep -E "image:" | cut -d ":" -f 5)
  swww img "$IMAGE_PATH"
  ~/.config/hypr/scripts/Refresh.sh
}

options=(
  'Mirror'
  'Laptop Only'
  'Second Screen Only'
  'Extend 1.00'
  'Extend 1.25'
  'Extend 1.50'
  'Extend 2.00'
)

answer=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Mode")


# Quit if not option selected
if [ -z ${answer} ] ; then 
  echo "No selection made"
  exit 1
fi

hyprctl reload
case $answer in
  Mirror)
    hyprctl keyword monitor ",preferred,auto,1,mirror,eDP-1"
    ;;
  'Laptop Only')
    hyprctl keyword monitor ",disable"
    ;;
  'Second Screen Only')
    hyprctl keyword monitor "eDP-1,disable"
    ;;
  Extend*) 
    mag=$(echo $answer | cut -d " " -f 2)

    hyprctl keyword monitor ",enable"
    hyprctl keyword monitor ",preferred,auto,$mag"
    ;;
esac
refresh
