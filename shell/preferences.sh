
prompt()
{
	exitcode=$?
	test $exitcode -eq 0 && exitcode="" || exitcode="\[\e[1;31m\]$? "
	export PS1="$exitcode\[\e[38;5;51m\]\u\[\e[38;5;255m\]@\[\e[38;5;244m\]\h \[\e[38;5;255m\]\w > "
}
PROMPT_COMMAND="prompt"

# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
# so it won't get overriden
if [ ! -a ~/.inputrc ]; then
	echo '$include /etc/inputrc' > ~/.inputrc
fi

# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> ~/.inputrc

# Scrolling autocomplition
bind TAB:menu-complete
export NERD_FONT=1
