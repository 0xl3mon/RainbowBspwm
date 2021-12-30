#!/bin/bash
random=$(find ~/.wallpapers -xtype f | sort -R | head -n 1)

feh --bg-fill $random
