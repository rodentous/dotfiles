### SHELL #############################################################################################################################################################################################
alias          reload=". ~/bash.sh"
alias            quit="exit"
hf() # history with fzf (a.k.a. he forgor)
{
	history | fzf
}


### PACKAGES ##########################################################################################################################################################################################
alias          pacget="sudo pacman -S --needed --noconfirm" # 'get' and 'pac' also work
alias          update="sudo pacman -Syu --noconfirm; yay -Sc --noconfirm"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qeq"
alias          delete="sudo pacman -Rucns"
gf() # get packages with fzf
{
	search -q "$@" | fzf --preview 'pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if [[ "$?" -eq 0 ]]; then
		gf "$@"
	fi
}
tf() # throw away packages with fzf
{
	[[ ! "$@" ]] && set -- "" # if no argument provided add "" as argument so grep won't break

	lspacs | grep "$@" | fzf --preview "pacman -Si {}" | sudo xargs pacman -Rucns --noconfirm
	[[ "$?" -eq 0 ]] && tf "$@"
}

# aur packages
alias          aurget="yay -S --needed --noconfirm" # 'aur' also works
alias       aursearch="yay -Ss"
af() # aur packages with fzf
{
	output="$( aursearch -q "$@" | fzf --preview 'yay -Si {}' | xargs yay -S --needed --noconfirm )"
	[[ -n "$output" ]] && af "$@"
}


### NAVIGATION ########################################################################################################################################################################################
alias            copy="sudo cp -rv"
alias            move="sudo mv -vf"
alias          rename="sudo mv -vf --no-copy"
alias          remove="sudo rip -i"
alias          revive="sudo rip -u"

alias              ez="sudo eza --oneline -aaXI '.' --color always --no-quotes"
alias              fz="fzf --height 75% --preview-window right:75% --ansi"
alias              rg="batgrep"

pv() # preview file or dir
{
	if [[ ! "$@" ]]; then
		sudo eza --oneline --no-quotes --color always --icons always $PWD
	elif [[ -f "$@" ]]; then
		sudo bat --color always "$@"
	else
		sudo eza --oneline --no-quotes --color always --icons always "$@"
	fi
}

zm() # zoxide and micro
{
	if [[ -f "$@" ]]; then
		micro "$@"
	else
		z "$@"
	fi
}

zf() # zoxide and fzf
{
	if [[ "$@" ]]; then
		zm "$@"
	fi

	path="$( ez | fz --preview '. ~/config/shell/alias.sh; pv {}' )"

	[[ $path ]] && zf "$path"
}

rf() # remove files with fzf
{
	if [[ "$@" ]]; then
		zm "$@"
	fi
	
	path="$( ez | fz --preview '. ~/config/shell/alias.sh; pv {}' )"
	
	if [[ $path ]]; then
		remove "./$path"
		rf .
	fi
}


### CONFIGURATION #####################################################################################################################################################################################
alias          calias="micro ~/config/shell/alias.sh; reload"

alias          ckitty="micro ~/config/kitty/kitty.conf"
alias          cmicro="micro ~/config/micro/settings.json"
alias          cfetch="micro ~/config/fastfetch/config.jsonc; ff"

alias          chyprl="micro ~/config/hypr/hyprland.conf"
alias          cbinds="micro ~/config/hypr/binds.conf"

alias          cewwww="micro ~/config/eww/eww.yuck"
alias          cstyle="micro ~/config/eww/eww.scss"

alias           cgrub="micro /etc/default/grub; regrub"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"


# dotfiles sync
alias         dotload="cat ~/config/dotfiles.toml > ~/config/chezmoi/chezmoi.toml; cat ~/config/dunst/dunstrc > ~/.config/dunst/dunstrc"
alias         dotinit="chezmoi init https://github.com/rodentous/dotfiles"
alias         dotpull="chezmoi update; dotload; reload"
alias         dotdiff="chezmoi diff"
alias         dotpush="chezmoi add"
alias         dotkill="chezmoi destroy"
alias         dotyeah="chezmoi git push"


### FUN ###############################################################################################################################################################################################
alias             say="toilet -f mono12 -F border"
alias             kms=":(){ :|: }; :"
alias             man="batman"
alias      wallpapers="find ~/config/wallpapers -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      activation="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias      killmyself="rm -rf / --no-preserve-root"
alias      microfetch="mf"

random()
{
	find "$@" -type f -print0 | shuf -zn1
}

ff() # fastfetch
{
	if [ $COLUMNS -lt 58 ] || [ $LINES -lt 10 ]; then
		clear
	elif [ $COLUMNS -lt 83 ] || [ $LINES -lt 20 ]; then
		mf
	else
		clear; fastfetch "$@"
	fi
}

mf() # minifetch
{
	clear; fastfetch "$@" --logo small -c ~/config/fastfetch/small.jsonc
}


# short variants
alias             clr="clear"
alias             get="pacget"
alias             pac="pacget"
alias             aur="aurget"
alias             rel="reload"

alias             ca="calias"
alias             ch="chyprl"
alias             cb="cbinds"
alias             cf="cfetch"
alias             ck="ckitty"
alias             cm="cmicro"
alias             cw="cewwww"


### SYSTEM ############################################################################################################################################################################################
alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias        hyprnate="sudo systemctl hibernate"
alias          recore="sudo mkinitcpio -P"
