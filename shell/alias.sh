# Main
alias          reload="clear; cd ~; . .bashrc"
alias            quit="exit"

neofetch()
{
	if [ $COLUMNS -lt 58 ]; then
		clear; fastfetch --logo small -s none | lolcat
	elif [ $COLUMNS -lt 96 ]; then
		clear; fastfetch --logo small -c ~/.config/fastfetch/small.jsonc | lolcat
	else
		clear; fastfetch --logo auto -s none | lolcat --force | fastfetch --raw -
	fi
}

# System
alias          recore="sudo mkinitcpio -P"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"

alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias       hybernate=""

# Configuration
dotget()
{
	dotsync
	cd ~/.dotfiles
	cp -rf ~/.dotfiles/. -t ~
	cd ~
}

dotsend()
{
	dotsync
	path=$(realpath --relative-to ~ $@)
	echo $path
	mkdir -p ~/.dotfiles/$path
	rm -rf ~/.dotfiles/$path
	cp -rf $@ -T ~/.dotfiles/$path
	cd ~/.dotfiles
	git add --all
	git commit -m "sync"
	git push
	cd ~
}

dotsync()
{
	rm -rf ~/.dotfiles
	gh repo clone rodentous/dotfiles ~/.dotfiles
	cd ~
}

alias           cbash="micro ~/bash.sh; reload"
alias          calias="micro ~/shell/alias.sh; reload"
alias          cprefs="micro ~/shell/preferences.sh; reload"
alias          ckitty="micro ~/.config/kitty/kitty.conf"
alias           cgrub="micro /etc/default/grub; regrub"
alias           cland="micro ~/.config/hypr/hyprland.conf"
alias          cbinds="micro ~/.config/hypr/binds.conf"
alias            cbar="micro ~/.config/waybar/config.jsonc"
alias       cbarstyle="micro ~/.config/waybar/style.css"
alias          cmicro="micro ~/.config/micro/settings.json"

# Packages
alias             get="sudo pacman -S"
alias          delete="sudo pacman -Rucns"
alias          update="sudo pacman -Syu; yay -Syuc;"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qe"
alias           steal="yay -S"
alias       yaysearch="yay -Ss"

yayfix()
{
	dir="$(mktemp -d)"
	git clone https://aur.archlinux.org/yay.git "$dir"
	cd "$dir"
	makepkg -sir
	cd
	rm -rf "$dir"
}


# Navigation
alias            copy="cp -rvi"
alias            move="mv -vi"
alias          rename="mv -vf --no-copy"
alias          remove="rm -r"
alias             fzf="fzf --height 20 --reverse --preview-window right:75% --preview 'source ~/shell/alias.sh; preview {}'"
alias            wofi="wofi --conf ~/.config/wofi/config --style ~/.config/wofi/frappe.css "
hist()
{
	cmd="$(history -w /dev/stdout | tac | fzf)"
	history -s "$cmd"
	eval "$cmd"
}

preview()
{
	if [[ "$@" ]]; then
		if [[ -f "$@" ]]; then
			if [[ "$@" == "*.png" ]]; then
				kitty icat "$@"
			else
				bat --color always "$@"
			fi
		else
			eza -l --no-time --no-filesize --no-user --no-permissions --icons always "$@"
		fi
	else
		eza -l --no-time --no-filesize --no-user --no-permissions --icons always "$@" $PWD
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
	# pwd
	path=$( ls -a | fzf )
	
	if [[ $path ]]; then
		zf "./$path"
	fi
}

# Fun
alias       wallpaper="find ~/Data/Wallpaper -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias        activate="killall activate-linux"
alias             say="toilet -f mono12 -F border"
alias            grow="cbonsai -l"
alias          matrix="cmatrix"
alias             kys=":(){ :|: }; :"
alias    killyourself="rm -rf / --no-preserve-root"
