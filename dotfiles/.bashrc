# exit if running non-interactively
case $- in
	*i*) ;;
	  *) return;;
esac

# get current git branch for PS1
git_branch () {
	GIT_BRANCH="$(git branch 2>/dev/null | grep '^*' | cut -c 3-)"
	if [ ! -z "$GIT_BRANCH" ] && [ "$GIT_BRANCH" != "master" ] && [ "$GIT_BRANCH" != "main" ]; then
		echo " * $GIT_BRANCH"
	fi
}

PS1='[\A] $(basename "$(pwd)")$(git_branch) | '

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

. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"