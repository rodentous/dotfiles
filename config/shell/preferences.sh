### PROMPT ############################################################################################################################################################################################
prompt()
{
	exitcode=$?
	test $exitcode -eq 0 && exitcode="" || exitcode="\[\e[1;31m\]$? "
	export PS1="$exitcode\[\e[38;5;51m\]\u\[\e[38;5;255m\]@\[\e[38;5;244m\]\h \[\e[38;5;255m\]\w > "
}
PROMPT_COMMAND="prompt"


### COMPLETION ########################################################################################################################################################################################
bind TAB:menu-complete                      # cycle options on tab, not just show them
bind "'\e[Z': menu-complete-backward"       # and shift+tab cycle backwards
bind "set show-all-if-ambiguous on"         # display a list of the matching files
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
