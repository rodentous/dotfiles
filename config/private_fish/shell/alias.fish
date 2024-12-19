### SHELL #############################################################################################################################################################################################
alias          reload="source ~/config/fish/config.fish"
alias            quit="exit"
function hf # history with fzf (a.k.a. he forgor)
	history | fzf
end


### PACKAGES ##########################################################################################################################################################################################
alias          pacget="sudo pacman -S --needed --noconfirm" # 'get' and 'pac' also work
alias          update="sudo pacman -Syu --noconfirm; yay -Sc --noconfirm"
alias          search="sudo pacman -Ss"
alias          lspacs="sudo pacman -Qeq"
alias          delete="sudo pacman -Rucns"

function gf # get packages with fzf
	search -q "$argv" | fzf --preview 'pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if test "$status" -eq 0
		gf "$argv"
	end
end

function tf # throw away packages with fzf
	test -n "$argv" && set argv "" # if no argument provided add "" as argument so grep won't break

	lspacs | grep $argv | fzf --preview "pacman -Si {}" | sudo xargs pacman -Rucns --noconfirm
	test -z $status && tf $argv
end

# aur packages
alias          aurget="yay -S --needed --noconfirm" # 'aur' also works
alias       aursearch="yay -Ss"
function af # aur packages with fzf
	set -l output "$( aursearch -q "$argv" | fzf --preview 'yay -Si {}' | xargs yay -S --needed --noconfirm )"
	test -n $output && af $argv
end


### NAVIGATION ########################################################################################################################################################################################
alias            copy="sudo cp -rv"
alias            move="sudo mv -vf"
alias          rename="sudo mv -vf --no-copy"
alias          remove="sudo rip -i"
alias          revive="sudo rip -u"

alias              ez="sudo eza --oneline -aaXI '.' --color always --no-quotes"
alias              fz="fzf --height 75% --preview-window right:75% --ansi"
alias              rg="batgrep"

function pv # preview file or dir
	if test -z "$argv"
		eza --oneline --no-quotes --color always --icons always $PWD
	else if test -f "$argv"
		bat --color always $argv
	else
		eza --oneline --no-quotes --color always --icons always $argv
	end
end

function zm # zoxide and micro
	if test -f "$argv"
		micro "$argv"
	else
		z "$argv"
	end
end

function zf # zoxide and fzf
	test -e "$argv" && zm $argv

	set -l path "$( ez | fz --preview 'pv {}' )"

	test -d "$path" && zf "$path"
end

function rf # remove files with fzf
	if test -n "$argv"
		zm "$argv"
	end
	
	set -l path "$( ez | fz --preview 'pv {}' )"
	
	if test -e "$path"
		remove "./$path"
		rf .
	end
end


### CONFIGURATION #####################################################################################################################################################################################
alias          calias="micro ~/config/fish/shell/alias.fish; reload"

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
alias         dotload="cat ~/config/dunst/dunstrc > ~/.config/dunst/dunstrc"
alias         dotinit="chezmoi init https://github.com/rodentous/dotfiles"
alias         dotpull="chezmoi update; dotload; reload"
alias         dotdiff="chezmoi diff"
alias         dotpush="chezmoi add"
alias         dotkill="chezmoi destroy"
alias         dotyeah="chezmoi git push"


### FUN ###############################################################################################################################################################################################
alias             say="toilet -f mono12 -F border"
alias             man="batman"
alias      wallpapers="find ~/config/wallpapers -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      activation="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias      killmyself="rm -rf / --no-preserve-root"
alias      microfetch="mf"

function random
	find $argv -type f -print0 | shuf -zn1
end

function ff # fastfetch
	if test $COLUMNS -lt 58 and test $LINES -lt 10
		clear
	else if test $COLUMNS -lt 83 and test $LINES -lt 20
		mf
	else
		clear; fastfetch --logo arch2 $argv
	end
end

function mf # minifetch
	clear; fastfetch $argv --logo small -c ~/config/fastfetch/small.jsonc
end


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
