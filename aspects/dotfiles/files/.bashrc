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

# silence zsh warning on darwin
export BASH_SILENCE_DEPRECATION_WARNING=1
if [ -x "/usr/bin/ufetch" ]; then
	/usr/bin/ufetch
fi

# local aliases
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

# machine-local bashrc, if exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# setup node management
export N_PREFIX="$HOME/n"
export PATH="$N_PREFIX/bin":"$PATH"

# load fzf stuff, if available
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
