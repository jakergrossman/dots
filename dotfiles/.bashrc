# exit if running non-interactively
case $- in
    *i*) ;;
    *) return;;
esac

# add directory arguments to PATH if:
#   1. The directory exists
#   2. The directory is not already present in PATH
add_to_path () {
    for dir in $@; do
        if [ -d "$dir" ] && [[ ! ":$PATH:" == *":$dir:"* ]]; then
            export PATH="$dir:$PATH"
        fi
    done
}

# get current git branch for PS1
git_branch () {
    GIT_BRANCH="$(git branch 2>/dev/null | grep '^*' | cut -c 3-)"
    if [ ! -z "$GIT_BRANCH" ] && \
           [ "$GIT_BRANCH" != "master" ] && \
           [ "$GIT_BRANCH" != "main" ]; then
        echo " * $GIT_BRANCH"
    fi
}

# recursively create directories,
# then cd to the last one
mkcd () {
    if [ "$#" -eq 0 ]; then
        >&2 echo "mkcd: expected at least one directory"
        >&2 echo "usage: mkcd DIRECTORY ..."
        return 1
    fi

    for n in "$@"; do
        mkdir -p "$n"
    done

    # `n' is implicitly saved from for loop
    cd "$n"
}

PS1='\[\e[0;90m\][\A]\[\e[0m\] \[\e[0;95m\]$(basename "$(pwd)")\[\e[0m\]\[\e[0;33m\]$(git_branch)\[\e[0m\] \[\e[0;91m\]|\[\e[0m\] '

# alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#shopt -s autocd # cd with just dir name

# silence zsh warning on darwin
export BASH_SILENCE_DEPRECATION_WARNING=1
if [ -x "/usr/bin/ufetch" ]; then
    /usr/bin/ufetch
fi

# platform specific settings
case "$OSTYPE" in
    darwin*)
        # put gnu-utils first to avoid g prefix
        add_to_path "/usr/local/opt/gnu-utils"

        # racket
        add_to_path "/Applications/Racket/bin"

        # MATLAB
        add_to_path "/Applications/Matlab/bin"
        ;;
esac


# load fzf stuff, if available
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

add_to_path "$HOME/.local/bin"

# machine-local bashrc, if exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
