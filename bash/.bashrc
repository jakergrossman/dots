# exit if running non-interactively
case $- in
	*i*) ;;
	  *) return;;
esac

# set prompt
PS1='\[\e[1;32m\]\w > \[\e[m\]'

# alias definitions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# local aliases
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

# set ENV variables
export EDITOR=vim

# hidden files, please
export FZF_DEFAULT_COMMAND="find . -printf \"%P\\\n\""
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# machine-local bashrc, if exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

ufetch
