#!/bin/sh

for file in ~/config/shell/*.sh; do
    . $file
done

clear
neofetch
