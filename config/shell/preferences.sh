### PROMPT ############################################################################################################################################################################################
get_prompt()
{
	[[ $? -eq 0 ]] && prompt="\e[1m\e[36m\u \e[37m\w > \e[0m" || prompt="\e[31;1m$? \u \w > \e[0m"
	export PS1="$prompt"
}
PROMPT_COMMAND="get_prompt"


### COMPLETION ########################################################################################################################################################################################
bind TAB:menu-complete                      # tab       cycle through completion options on tab
bind "'\e[Z': menu-complete-backward"       # shift+tab cycle backwards
# bind "set show-all-if-ambiguous on"         # display a list of the matching files
bind "set menu-complete-display-prefix on"
bind "set completion-ignore-case on"

bind "'\C-h': backward-kill-word"           # ctrl+backspace removes word


### NERD FONT #########################################################################################################################################################################################
export NERD_FONT=1


### TRUE COLOR ########################################################################################################################################################################################
export COLORTERM=truecolor
export MICRO_TRUECOLOR=1


### HISTORY ###########################################################################################################################################################################################
export HISTCONTROL=ignoreboth:erasedups     # delete duplicates
shopt -s histverify                         # "!command" will be editable

export HISTSIZE=                            # I N F I N I T E
export HISTFILESIZE=                        # H I S T O R Y


eval "$(thefuck --alias)"

export EDITOR="micro"
