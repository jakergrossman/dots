# shorties
alias l="ls -lah --color=auto"
alias p="sudo pacman"
alias g="git"
alias gr="grep"

# even short commands
alias gd="git diff"
alias gs="git status"
alias gh="git log --oneline --all --decorate --graph"

# systemctl
alias sc="sudo systemctl"
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

