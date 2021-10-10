# shorties
alias l="ls -lah"
alias v="vim"
alias p="sudo pacman"
alias g="git"
alias gr="grep"


# even short commands
alias gd="git diff"
alias gs="git status"
alias gh="git log --oneline --all --decorate --graph"

# alternate vim uses
alias view="vim -u \"NONE\" -M" # viewer
alias vi="vim --clean -u \"NONE\"" # clean mode

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

alias ncpamixer="bash -c ncpamixer"
