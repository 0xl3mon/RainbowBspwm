#!/bin/bash
# Script for sxhkd to Shutdown de system

option=$(/usr/bin/echo -e "Si\nNo" | rofi -i -dmenu -no-config -theme "${HOME}/.config/polybar/scripts/rofi/launcher.rasi" -font "hack 10" -show combi -icon-theme "Papirus" -p "¿Esta Seguro que desea Apagar el systema?" -show-icons -l 2)

if [[ "$option" == "Si" ]]; then
  notify-send -u normal -t 1200 "Apagando el Sistema 💤"
  sleep 3
  /usr/sbin/shutdown now
elif [[ "$option" == "No" ]]; then
  notify-send -u normal -t 1200 "Apagado Cancelado ⚡"
fi
