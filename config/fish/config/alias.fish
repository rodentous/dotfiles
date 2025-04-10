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
	search -q "$argv" | fzf --preview 'clear; pacman -Si {}' | sudo xargs pacman -S --needed --noconfirm
	if test "$status" -eq 0
		gf "$argv"
	end
end

function tf # throw away packages with fzf
	test -n "$argv" && set argv "" # if no argument provided add "" as argument so grep won't break

	lspacs | grep "$argv" | fzf --preview "clear; pacman -Si {}" | sudo xargs pacman -Rucns --noconfirm
	test $status -eq 0 && tf $argv
end

# aur packages
alias          aurget="yay -S --needed --noconfirm" # 'aur' also works
alias       aursearch="yay -Ss"
function af # aur packages with fzf
	set -l output "$( aursearch -q "$argv" | fzf --preview 'clear; yay -Si {}' | xargs yay -S --needed --noconfirm )"
	test -n $output && af $argv
end


### NAVIGATION ########################################################################################################################################################################################
alias            copy="cp -rv"
alias            move="mv -vf"
alias          rename="mv -vf --no-copy"
alias          remove="rip -i"
alias          revive="rip -u"
alias              mk="mkdir -p"

alias              ez="eza --oneline -aaXI '.' --color always --no-quotes"
alias              fz="fzf --height 75% --preview-window right:75% --ansi"
alias              rg="batgrep"

function pv # preview file or dir
	if test -z "$argv"
		eza --oneline --no-quotes --color always --icons always $PWD
	else if test $(path extension $argv) = ".png"
	    kitten icat $argv
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

    test "$status" -ne 0 && return

	test -d "$path" && zf "$path"
	test -f "$path" && zm "$path" && zf
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
alias         cconfig="echo export XDG_CONFIG_HOME="$HOME/config" > /etc/profile.d/config.sh"
alias          calias="micro ~/config/fish/config/alias.fish; reload; clear"

alias          ckitty="micro ~/config/kitty/kitty.conf"
alias          cmicro="micro ~/config/micro/settings.json"
alias          cfetch="micro ~/config/fastfetch/config.jsonc; ff"
alias          chyprl="micro ~/config/hypr/hyprland.conf"
alias          cbinds="micro ~/config/hypr/binds.conf"

alias           cwofi="cd ~/config/wofi"
alias            ceww="cd ~/config/eww"
alias           cfish="micro ~/config/fish/config/preferences.fish"

alias           cgrub="micro /etc/default/grub; regrub"
alias      cgrubtheme="micro /usr/share/grub/themes"
alias          regrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias         ttyfont="cd /usr/share/kbd/consolefonts; setfont"


# dotfiles sync
alias         dotinit="chezmoi init https://github.com/rodentous/dotfiles"
alias         dotpull="chezmoi update"
alias         dotdiff="chezmoi diff"
alias         dotpush="chezmoi add"
alias         dotkill="chezmoi destroy"
function dotyeah
    cd ~/.local/share/chezmoi
    git add -A
    git commit -m 'sync'
    git push
    cd ~
end
function dotinit
    chezmoi init https://github.com/rodentous/dotfiles
    rm -rf ~/.config
    ln -s ~/config ~/.config
end

### FUN ###############################################################################################################################################################################################
alias             say="toilet -f mono12 -F border"
alias             man="batman"
alias      wallpapers="find ~/config/wallpapers -type f -print0 | shuf -zn1 | xargs -0 swww img -t any"
alias      activation="killall activate-linux; activate-linux -wdv -c 1-1-1-0.5 -y 150"
alias      killmyself="rm -rf / --no-preserve-root"
alias      microfetch="mf"
alias      wvkeyboard="wvkbd-mobintl -L 300 -R 5 --bg 1e1e2e --fg 11111b --fg-sp 181825 --text cdd6f4 --press 313244 --press-sp 313244 --fn CaskaydiaCoveNF"

function random
	find $argv -type f -print0 | shuf -zn1
end

function ff # fastfetch
	if test $COLUMNS -lt 58
		clear
	else if test $COLUMNS -lt 83
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
alias             cf="cfish"
alias             ck="ckitty"
alias             cm="cmatrix"
alias             cw="ceww"


### SYSTEM ############################################################################################################################################################################################
alias        shutdown="shutdown now"
alias         restart="shutdown -r now"
alias        hyprnate="sudo systemctl hibernate"
alias          recore="sudo mkinitcpio -P"
