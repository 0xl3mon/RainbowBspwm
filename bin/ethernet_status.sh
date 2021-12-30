#!/bin/bash
ethernet=$(/usr/sbin/ifconfig eth0 2>/dev/null| grep "inet " | awk '{print $2}')

echo -e "%{F#00FFFF} %{F#ffffff} $ethernet%{u-}"

