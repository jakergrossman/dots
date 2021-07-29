# set ENV variables
export EDITOR=vim # use vim

export FZF_DEFAULT_COMMAND="find . -printf \"%P\\\n\"" # hidden files, too
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# load .bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

# start X (and therefore XMonad) on login
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
