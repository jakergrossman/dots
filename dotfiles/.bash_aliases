# shorties
alias l="ls -lah"
alias p="sudo pacman"
alias g="git"
alias gr="grep"


# even short commands
alias gd="git diff"
alias gs="git status"
alias gh="git log --oneline --all --decorate --graph"

# systemctl
alias sc="sudo systemctl"

# output color grep and ls to terminal
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ ! -z $(which nvim 2>/dev/null) ]; then
	alias v='nvim'
fi

# system specific aliases
case "$OSTYPE" in
    darwin*)
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
        alias matlab="/Applications/MATLAB_R2021b.app/bin/matlab"
        ;;
esac

