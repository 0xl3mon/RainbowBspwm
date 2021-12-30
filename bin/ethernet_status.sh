#!/bin/bash
ethernet=$(/usr/sbin/ifconfig eth0 2>/dev/null| grep "inet " | awk '{print $2}')

echo -e "%{F#CCbd93f9} %{F#ffffff}$ethernet%{u-}"
