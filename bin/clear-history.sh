#!/bin/bash

Yellow='\e[93m'
RESET='\e[0m'

function clear-history() {
    /usr/bin/cat /dev/null > /home/l3mon/.zsh_history && history -c
    /usr/bin/cat /dev/null > /root/.zsh_history && history -c
    echo -e "\b${Yellow}[*] All the records are clean${RESET}"
    }

clear-history
