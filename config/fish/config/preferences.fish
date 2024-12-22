export COLORTERM=truecolor
export MICRO_TRUECOLOR=1


function fish_prompt
    if test "$status" != "0"
        echo (set_color red)$status (set_color cyan)$USER (set_color white)$PWD "> "
    else
        echo (set_color cyan)$USER (set_color white)$PWD "> "
    end
end
