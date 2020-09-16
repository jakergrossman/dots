# use vim as default editor
export EDITOR="vim"

# if vim is present
if command -v vim &> /dev/null
then
	# use vim instead of less(1)
	export MANPAGER="/bin/sh -c \"col -b | \
		vim -c 'set ft=man ts=8 nomod nolist nonu noma hlsearch' - --not-a-term\""
fi

# change default fzf command to show hidden files
export FZF_DEFAULT_COMMAND='find -L .'
