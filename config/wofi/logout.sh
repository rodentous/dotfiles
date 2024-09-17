#!/bin/bash

conf="$HOME/config/hypr/wofi/config/prompt"
style="$HOME/config/hypr/wofi/src/mocha/style.css"   # Same as default wofi launcher

options=("lock 
logout 
reboot 
shutdown  ")

sel_option=$(echo -e "${options[@]}" | wofi --dmenu --conf=$conf --style=$style --prompt "bye :3")

# Check if the user selected an option
if [[ -n $sel_option ]]; then
	# Extract the action part without the glyph
	action=$(echo "$sel_option" | awk '{print $NF}')

	# Ask for confirmation
	confirm=$(echo -e "Yes\nNo\n" | wofi --dmenu --conf=$conf --style=$style --prompt "Confirm $action ?")

	# If the user confirmed, execute the selected option
	if [[ $confirm == "Yes" ]]; then
		case $action in
			"lock")
				hyprlock -f
			;;
			"logout")
				hyprctl dispatch exit
			;;
			"reboot")
				shutdown -r now
			;;
			"shutdown")
				shutdown now
			;;
		esac
	fi
fi

# Exit the script
exit 0
