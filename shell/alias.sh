# Main
alias     neofetch="clear; fastfetch --disk-show-readonly off"
alias       reload=". ~/.bashrc"
alias         quit="exit"
alias	  dotsync=""
alias     dotfetch=""

# System
alias   reloadcore="sudo mkinitcpio -P"
alias   reloadgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias      ttyfont="cd /usr/share/kbd/consolefonts; setfont"

# Configuration
alias        cbash="micro ~/.bashrc; reload"
alias       calias="micro ~/shell/alias.sh; reload"
alias       cprefs="micro ~/shell/preferences.sh; reload"
alias        cgrub="micro /etc/default/grub; reload-grub"

# Packages
alias         get="sudo pacman -S"
alias      search="sudo pacman -Ss"
alias      remove="sudo pacman -Rucns"
alias      delete="sudo pacman -Rns"
alias      update="sudo pacman -Syu; yay -Syu;"
alias       steal="sudo yay -S"
alias    listpacs="sudo pacman -Qe"
alias listpacsall="sudo pacman -Q"

# Other
compile()
{
    if ! [ -f "$1" ]; then
        echo "$1 not found"
        return
    fi

    if clang++ "$1"; then
		echo "$1:"
	   ./a.out
	   rm ./a.out
    fi
}

go()
{
	if [ -f "$1" ]; then
		micro "$1"
	else
		z "$1"
		eza --icons always -Alb --no-time --no-permissions --no-user
	fi
}

alias            home="go ~"
alias android-storage="go /storage/emulated/0"
alias         pycharm="rm /home/rodent/.var/app/com.jetbrains.PyCharm-Community/config/JetBrains/PyCharmCE2023.3/.lock"

# Fun
alias      deactivate="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias        activate="killall activate-linux"
alias             say="toilet -f mono12 -F border"
alias            grow="cbonsai -l"
alias          matrix="cmatrix"

alias       minecraft="sudo java -jar ~/Data/Games/Minecraft/TLauncher-2.895.jar"
