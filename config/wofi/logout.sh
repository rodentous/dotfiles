#!/bin/bash

options=("lock 
logout 
reboot 
shutdown  ")

selected_option=$(echo -e "${options[@]}" | wofi -c ~/config/wofi/config/prompt -s ~/config/wofi/src/mocha/style.css --dmenu)

# Check if the user selected an option
if [[ -n $select_option ]]; then
	# Extract the action part without the glyph
	action=$(echo "$selected_option" | awk '{print $NF}')

	case $action in
		"logout")
			hyprctl dispatch exit
		;;
		"lock")
			hyprlock -f
		;;
		"reboot")
			shutdown -r now
		;;
		"shutdown")
			shutdown now
		;;
	esac
fi
