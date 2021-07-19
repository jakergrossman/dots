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

# set ENV variables
export EDITOR=vim

# hidden files, please
export FZF_DEFAULT_COMMAND="find . -printf \"%P\\\n\""
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

ufetch
