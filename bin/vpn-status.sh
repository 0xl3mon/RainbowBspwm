#!/bin/bash
vpn=$(/usr/sbin/ifconfig tun0 2>/dev/null | grep 'inet ' | awk '{print $2}')

echo -e "%{F#960909}ﱲ %{F#fff} Disconnected%{u-}"
#echo -e "%{u#111670}%{+u} %{F#1562bf} %{F#fff}%{F#00ff00}$vpn%{F#fff}%{u-}"

