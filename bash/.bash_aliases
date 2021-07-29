# shorties
alias l="ls -lah"
alias v="vim"
alias p="sudo pacman"
alias g="git"


# even short commands
alias gd="git diff"
alias gs="git status"
alias gh="git log --oneline --all --decorate --graph"

# alternate vim uses
alias view="vim -u \"NONE\" -M" # viewer
alias vi="vim --clean -u \"NONE\"" # clean mode

# override default behavior
alias mv="mv -i" # be less destructive
alias rm="rm -i"
