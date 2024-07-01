# Main
alias          reload="clear; cd ~; . ~/bash.sh"
alias            quit="exit"
alias	      dotsync=""
alias        dotwrite=""

neofetch()
{
	if [ $COLUMNS -lt 58 ]; then
		clear; fastfetch --logo small -s none | lolcat
	elif [ $COLUMNS -lt 122 ]; then
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
alias           cbash="micro ~/bash.sh; reload"
alias          calias="micro ~/shell/alias.sh; reload"
alias          cprefs="micro ~/shell/preferences.sh; reload"
alias          ckitty="micro ~/.config/kitty/kitty.conf"
alias           cgrub="micro /etc/default/grub; reloadgrub"
alias           cland="micro ~/.config/hypr/hyprland.conf"
alias          cbinds="micro ~/.config/hypr/binds.conf"

# Packages
alias             get="sudo pacman -S"
alias          delete="sudo pacman -Rucns"
alias          update="sudo pacman -Syu; yay -Syu;"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qe"
alias           steal="yay -Sc"
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
alias             fzf="fzf --height 20 --reverse"
alias              ls="(echo ..; eza -l --no-time --no-filesize --no-user --no-permissions --icons never --color never)"

hist()
{
	$(history -w /dev/stdout | tac | fzf)
}

preview()
{
	if [ $1 ]; then
		if [ -f $1 ]; then
			if [ $1 == "*.png" ]; then
				echo "IMAGEEEEEEEEEE"
				kitty icat $1
			else
				bat --color always $1
			fi
		else
			eza -l --no-time --no-filesize --no-user --no-permissions --icons always $2 $1
		fi
	else
		eza -l --no-time --no-filesize --no-user --no-permissions --icons always $2 $PWD
	fi
}

zm()
{
	if [ $1 ]; then
		if [ -f $1 ]; then
			micro $1
		else
			z $1
		fi
	else
		z $PWD
	fi
}

zf()
{
	if [ $1 ]; then
		zm $1
	else
		zm $PWD
	fi
	pwd
	a=$( ls | fzf --preview ". ~/shell/alias.sh; preview {}" )
	
	if [ $a ]; then
		zm "./$a"
	fi
}

zff()
{
	if [ $1 ]; then
		zm $1
	else
		zm $PWD
	fi
	pwd
	a=$( ls | fzf --preview ". ~/shell/alias.sh; preview {}" )
	
	if [ $a ]; then
		zff "./$a"
	fi
}

# Fun
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias        activate="killall activate-linux"
alias             say="toilet -f mono12 -F border"
alias            grow="cbonsai -l"
alias          matrix="cmatrix"
alias             kys=":(){ :|: }; :"
alias    killyourself="rm -rf / --no-preserve-root"
