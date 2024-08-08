### SHELL #############################################################################################################################################################################################
alias          reload=". ~/bash.sh"
alias            quit="exit"
hf() # history fzf (a.k.a. he forgor)
{
     local cmd="$(__fzf_history__)" 
     read -rei "$cmd" -p "${PS1@P}" cmd 
     history -s "$cmd" # append to history 
     eval "$cmd"
}


### PACKAGES ##########################################################################################################################################################################################
alias          pacget="sudo pacman -S --needed --noconfirm" # 'get' and 'pac' also work
alias          update="sudo pacman -Syu --noconfirm; yay -Sc --noconfirm"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qeq"
alias          delete="sudo pacman -Rucns"
gf() # get packages with fzf (it cant get u gf sry)
{
	search -q "$@" | fz --preview 'pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if [[ "$?" -eq 0 ]]; then
		gf "$@"
	fi
}
tf() # throw away packages with fzf (a.k.a. who tf bloats my linux?!)
{
	[[ ! "$@" ]] && set -- "" # if no argument provided add "" as argument so grep won't break

	lspacs | grep "$@" | fz --preview "pacman -Si {}" | sudo xargs pacman -Rucns --noconfirm
	[[ "$?" -eq 0 ]] && tf "$@"
}

# aur packages
alias          aurget="yay -S --needed --noconfirm" # 'aur' also works
alias       aursearch="yay -Ss"
af() # aur packages fzf
{
	output="$( aursearch -q "$@" | fz --preview 'yay -Si {}' | xargs yay -S --needed --noconfirm )"
	[[ -n "$output" ]] && af "$@"
}


### NAVIGATION ########################################################################################################################################################################################
alias            copy="sudo cp -rvi"
alias            move="sudo mv -vfi"
alias          rename="sudo mv -vfi --no-copy"
alias          remove="sudo rm -rfi"

# alias              ls="ez"
alias              ez="eza --oneline -aaXI '.' --color always --no-quotes"
alias              fz="fzf --height 75% --preview-window right:75% --ansi"
alias              rg="batgrep"
pv() # preview files and directories
{
	if [[ ! "$@" ]]; then
		eza --oneline --no-quotes --color always --icons always $PWD
	elif [[ -f "$@" ]]; then
		bat --color always "$@"
	else
		eza --oneline --no-quotes --color always --icons always "$@"
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

zf() # zoxide and fzf (a.k.a. where z fuck are my files?)
{
	zm "$@"

	path="$( ez | fz --preview '. ~/config/shell/alias.sh; pv {}' )"
	
	[[ $path ]] && zf "$path"
}

rf() # remove files with fzf
{
	path="$( ez | fz --preview '. ~/config/shell/alias.sh; pv {}' )"
	
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
alias          chybar="micro ~/config/waybar/config.jsonc"
alias          cstyle="micro ~/config/waybar/style.css"
alias          cmicro="micro ~/config/micro/settings.json"
alias          cfetch="micro ~/config/fastfetch/config.jsonc; ff"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"


# dotfiles sync
alias         dotinit="chezmoi init https://github.com/rodentous/dotfiles"
alias         dotpull="chezmoi update; rm ~/README.md; cat ~/config/dotfiles.toml > ~/config/chezmoi/chezmoi.toml; reload"
alias         dotdiff="chezmoi diff"
alias         dotpush="chezmoi add"
alias         dotkill="chezmoi destroy"
alias         dotyeah="chezmoi git push"


### FUN ###############################################################################################################################################################################################
alias             say="toilet -f mono12 -F border"
alias             kms=":(){ :|: }; :"
alias             man="batman"
alias      wallpapers="find ~/config/wallpapers -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias      killmyself="rm -rf / --no-preserve-root"
alias       minifetch="mf"

ff() # fastfetch
{
	if [ $COLUMNS -lt 58 ]; then
		clear; fastfetch "$@" --logo small -s none | lolcat
	elif [ $COLUMNS -lt 96 ]; then
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
alias             cal="calias"
alias             get="pacget"
alias             pac="pacget"
alias             aur="aurget"
alias             fuk="fuck"
alias             fuc="fuck"


### SYSTEM ############################################################################################################################################################################################
alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias       hypernate="sudo systemctl hibernate"
alias          recore="sudo mkinitcpio -P"
