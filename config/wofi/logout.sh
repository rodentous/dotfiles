set -l options "logout  
lock  
reboot  
shutdown  "

set -l action $(echo "$options" | wofi -c ~/config/wofi/prompt --dmenu)

# Check if the user selected an option
if test -n "$action"

	switch "$action"
		case "logout  "
			hyprctl dispatch exit
		case "lock  "
			hyprlock
		case "reboot  "
			reboot
		case "shutdown  "
			shutdown now
	end

end
