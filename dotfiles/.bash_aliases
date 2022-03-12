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

# alias vim -> nvim, if it exists on the path
[ ! -z "$(command -v nvim)" ] && alias vim="nvim"

# platform specific aliases
case "$OSTYPE" in
    darwin*)
        # TODO: find the utterance that brings me to the SO page
        #       that mentions emacs can't be symlinked
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
        ;;
esac

# machine local aliases
if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi