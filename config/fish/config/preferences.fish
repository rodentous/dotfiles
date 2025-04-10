export COLORTERM=truecolor
export MICRO_TRUECOLOR=1
# export NEWT_COLORS="window=black" nmtui

set -g fish_greeting ""

function fish_prompt
    set exstat $status
    if [ $exstat != 0 ]
        set_color red
        echo -n $exstat" "
    end
    set_color cyan
    echo -n (whoami)" "
    set_color white
    # echo -n @
    # set_color cyan
    # echo -n (hostnamectl hostname)" "
    set_color white
    echo -n (dirs)
    if [ $exstat = 0 ]
        set_color white
    else
        set_color red
    end
    echo -n -e " \$ "
end


tty-colorscheme catppuccin-mocha
clear
