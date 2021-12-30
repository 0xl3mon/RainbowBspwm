 #!/bin/bash
 vpn=$(/usr/sbin/ifconfig tun0 2>/dev/null | grep 'inet ' | awk '{print $2}')
 
 if [ -z "$vpn" ]; then
     echo -e "%{F#CCc9c90a}  %{F#fff}Disconnected%{u-}"
 elif [ -n "$vpn" ]; then
     echo -e "%{F#CC50fa7b}  %{F#fff}Disconnected%{u-}"
 fi
