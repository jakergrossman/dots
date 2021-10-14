# set ENV variables
export EDITOR=vim
export TERMINAL=alacritty

export FZF_DEFAULT_COMMAND="find . -printf \"%P\\\n\"" # hidden files, too
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# TODO: make sure bash aspect works across all platforms
if [ -f ~/.profile ]; then
    . ~/.profile
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
