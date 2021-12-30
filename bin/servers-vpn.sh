#!/bin/bash

# Checking enable/disable iface
check_iface=$(ifconfig | grep -P "tun[\d?]")

# List of countries
countries="$HOME/.config/bin/paises.txt"

# Listando Menu y guardando el input
option=$(/usr/bin/cat "$countries" |  rofi -i -dmenu -no-config -theme ~/.config/polybar/cuts/scripts/rofi/launcher.rasi -p "Nordvpn")

if [[ -z "$check_iface" ]] ; then
  # Loop para comprobar si la option existe
  while read -r line ; do
    if [[ "$option" == "$line" ]] ; then
      notify-send -u normal -t 1200 "En Proceso de Conexion : "
      timeout 8 /usr/bin/nordvpn c "$option"
    fi
  done < "$countries"

else
  notify-send -u critical -t 1200 "Error: Ya existe una vpn conectada " 
fi
