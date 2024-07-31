### SHELL #############################################################################################################################################################################################
alias          reload=". ~/bash.sh"
alias            quit="exit"
hf()
{
	cmd="$(history -w /dev/stdout | fz --no-sort --tac)"
	history -s "$cmd"
	eval "$cmd"
}


### PACKAGES ##########################################################################################################################################################################################
alias          pacget="sudo pacman -S --needed --noconfirm"
alias          update="sudo pacman -Syu --noconfirm; yay -Sc --noconfirm"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qeq"
alias          delete="sudo pacman -Rucns"
gf()
{
	search -q "$@" | fz --preview 'sudo pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if [[ "$?" -eq 0 ]]; then
		pf "$@"
	fi
}
tf()
{
	if [[ ! "$@" ]]; then
		set -- ""
	fi
	lspacs | grep "$@" | fz --preview 'sudo pacman -Si {}' | sudo xargs pacman -Rucns --noconfirm
	if [[ "$?" -eq 0 ]]; then
		df "$@"
	fi
}

# aur pacs
alias          aurget="yay -S --needed --noconfirm"
alias       aursearch="yay -Ss"
af()
{
	output=$( aursearch -q "$@" | fz --preview 'yay -Si {}' | xargs yay -S --needed --noconfirm )
	if [[ -n "$output" ]]; then
		af "$@"
	fi
}


### NAVIGATION ########################################################################################################################################################################################
alias            copy="sudo cp -rvi"
alias            move="sudo mv -vfi"
alias          rename="sudo mv -vfi --no-copy"
alias          remove="sudo rm -rfi"

alias              ez="eza -aaXI '.' --color always --no-quotes"
alias              fz="fzf --reverse --height 75% --preview-window right:75% --ansi"
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
		rf "$@"
	fi
}


### CONFIGURATION #####################################################################################################################################################################################
alias           cbash="micro ~/bash.sh; reload"
alias          calias="micro ~/config/shell/alias.sh; reload"
alias          cprefs="micro ~/config/shell/preferences.sh; reload"
alias          ckitty="micro ~/config/kitty/kitty.conf"
alias           cgrub="micro /etc/default/grub; regrub"
alias          chyprl="micro ~/config/hypr/hyprland.conf"
alias          cbinds="micro ~/config/hypr/binds.conf"
alias            cbar="micro ~/config/waybar/config.jsonc"
alias          cstyle="micro ~/config/waybar/style.css"
alias          cmicro="micro ~/config/micro/settings.json"
alias          cfetch="micro ~/config/fastfetch/config.jsonc; ff"

# dotfiles sync
alias         dotinit="chezmoi init https://github.com/rodentous/dotfiles"
alias         dotpull="chezmoi update; rm ~/README.md; cat ~/config/dotfiles.toml > ~/config/chezmoi/chezmoi.toml; reload"
alias         dotdiff="chezmoi diff"
alias         dotpush="chezmoi add"
alias         dotkill="chezmoi destroy"
alias         dotyeah="chezmoi git push"


### FUN ###############################################################################################################################################################################################
alias             say="toilet -f mono12 -F border"
alias             kys=":(){ :|: }; :"
alias      wallpapers="find ~/Data/Media/Wallpaper -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias    killyourself="rm -rf / --no-preserve-root"
ff()
{
	if [ $COLUMNS -lt 58 ]; then
		clear; fastfetch "$@" --logo small -s none | lolcat
	elif [ $COLUMNS -lt 96 ]; then
		clear; fastfetch "$@" --logo small -c ~/config/fastfetch/small.jsonc | lolcat
	else
		clear; fastfetch "$@"
	fi
}

# typos
alias             cal="calias"
alias             get="pacget"
alias             pac="pacget"
alias             fuk="fuck"
alias             fuc="fuck"


### SYSTEM ############################################################################################################################################################################################
alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias       hybernate=""

alias          recore="sudo mkinitcpio -P"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"
