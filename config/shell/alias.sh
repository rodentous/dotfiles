### MAIN ##############################################################################################################################################################################################
alias          reload=". ~/bash.sh"
alias            quit="exit"


### PACKAGES ##########################################################################################################################################################################################
alias             get="sudo pacman -S --needed --noconfirm"
alias          update="sudo pacman -Syu --noconfirm; yay -Sc --noconfirm"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qeq"
alias          delete="sudo pacman -Rucns"

alias           steal="yay -S --needed --noconfirm"
alias       yaysearch="yay -Ss"

alias          pacfix="remove /var/lib/pacman/db.lck"
yayfix()
{
	dir="$(mktemp -d)"
	git clone https://aur.archlinux.org/yay.git "$dir"
	cd "$dir"
	makepkg -sir
	cd
	rm -rf "$dir"
}


### NAVIGATION ########################################################################################################################################################################################
alias            copy="sudo cp -rv"
alias            move="sudo mv -vf"
alias          rename="sudo mv -vf --no-copy"
alias          remove="sudo rm -rf"

alias              ez="eza -aaXI '.' --color always --no-quotes"
alias              fz="fzf --reverse --height 100% --preview-window right:75% --ansi"

hf()
{
	cmd="$(history -w /dev/stdout | tac | fz)"
	history -s "$cmd"
	eval "$cmd"
}

pv()
{
	if [[ "$@" ]]; then
	
		if [[ -f "$@" ]]; then
			bat --color always "$@"
		else
			eza --oneline --no-quotes --color always --icons always "$@"
		fi

	else
		eza --oneline --no-quotes --color always --icons always "$@" $PWD
	fi
}


zm()
{
	if [[ "$@" ]]; then
		if [[ -f "$@" ]]; then
			micro "$@"
		else
			z "$@"
		fi
	else
		z "$@" $PWD
	fi
}

zf()
{
	zm "$@"

	path=$( ez | fz --preview ". ~/config/shell/alias.sh; pv {}" )
	
	if [[ $path ]]; then
		zf "./$path"
	fi
}

rf()
{
	zm "$@"

	path=$( ez | fz --preview ". ~/config/shell/alias.sh; pv {}" )
	
	if [[ $path ]]; then
		remove "./$path"
	fi
}

df()
{
	if [[ ! "$@" ]]; then
		set -- ""
	fi
	lspacs | grep "$@" | fz --preview 'sudo pacman -Si {}' | sudo xargs pacman -Rucns --noconfirm
	if [[ "$?" -eq 0 ]]; then
		df "$@"
	fi
}

pf()
{
	search -q "$@" | fz --preview 'sudo pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if [[ "$?" -eq 0 ]]; then
		pf "$@"
	fi
}

yf()
{
	output=$( yaysearch -q "$@" | fz --preview 'yay -Si {}' | xargs yay -S --needed --noconfirm )
	if [[ -n "$output" ]]; then
		yf "$@"
	fi
}


### CONFIGURATION #####################################################################################################################################################################################
alias           cbash="micro ~/bash.sh; reload"
alias          calias="micro ~/config/shell/alias.sh; reload"
alias          cprefs="micro ~/config/shell/preferences.sh; reload"
alias          ckitty="micro ~/config/kitty/kitty.conf"
alias           cgrub="micro /etc/default/grub; regrub"
alias           cland="micro ~/config/hypr/hyprland.conf"
alias          cbinds="micro ~/config/hypr/binds.conf"
alias            cbar="micro ~/config/waybar/config.jsonc"
alias       cbarstyle="micro ~/config/waybar/style.css"
alias          cmicro="micro ~/config/micro/settings.json"
alias          cfetch="micro ~/config/fastfetch/config.jsonc"


### FUN ###############################################################################################################################################################################################
alias       wallpaper="find ~/Data/Media/Wallpaper -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias        activate="killall activate-linux"
alias             say="toilet -f mono12 -F border"
alias            grow="cbonsai -l"
alias          matrix="cmatrix"
alias             kys=":(){ :|: }; :"
alias    killyourself="rm -rf / --no-preserve-root"

neofetch()
{
	if [ $COLUMNS -lt 58 ]; then
		clear; fastfetch --logo small -s none | lolcat
	elif [ $COLUMNS -lt 96 ]; then
		clear; fastfetch --logo small -c ~/config/fastfetch/small.jsonc | lolcat
	else
		clear; fastfetch
	fi
}


### SYSTEM ############################################################################################################################################################################################
alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias       hybernate=""

alias          recore="sudo mkinitcpio -P"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"
