# exit if running non-interactively
case $- in
	*i*) ;;
	  *) return;;
esac

# set prompt
PS1='[\[\e[1;31m\]\h@\u \w \[\e[m\]]$ '

# alias definitions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

shopt -s autocd # cd with just dir name

# local aliases
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# machine-local bashrc, if exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

if [ -x "/usr/bin/ufetch" ]; then
	/usr/bin/ufetch
fi