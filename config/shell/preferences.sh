### PROMPT ############################################################################################################################################################################################
prompt()
{
	exitcode=$?
	test $exitcode -eq 0 && exitcode="" || exitcode="\[\e[1;31m\]$? "
	export PS1="$exitcode\[\e[38;5;51m\]\u\[\e[38;5;255m\]@\[\e[38;5;244m\]\h \[\e[38;5;255m\]\w > "
}
PROMPT_COMMAND="prompt"

### COMPLETION ########################################################################################################################################################################################
# Cycle options on Tab, not just show them
bind TAB:menu-complete
# And Shift-Tab cycle backwards
bind '"\e[Z": menu-complete-backward'
# Display a list of the matching files
bind "set show-all-if-ambiguous on"
# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"
#set completion-ignore-case On

### NERD FONT #########################################################################################################################################################################################
export NERD_FONT=1

### TRUE COLOR ########################################################################################################################################################################################
export COLORTERM=truecolor
export MICRO_TRUECOLOR=1

### HISTORY ###########################################################################################################################################################################################
export HISTCONTROL=ignoreboth:erasedups      # no duplicates in history
shopt -s histverify                          # "!command" will be editable
# INFINITE HISTORY!
export HISTSIZE= 
export HISTFILESIZE=
