# set editor to vim
set EDITOR=vim

# if stack is installed
if [ -x $(which stack) ]; then
    alias ghci="stack ghci"
fi

# git aliases
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'

# alias 
