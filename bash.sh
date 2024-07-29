#!/bin/sh

for file in ~/config/shell/*.sh; do
    . $file
done

eval "$(thefuck --alias)"
clear
neofetch
