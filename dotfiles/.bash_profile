# set ENV variables
export EDITOR=nvim
export TERMINAL=alacritty

# system specific exports
if   [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # linux
    export FZF_DEFAULT_COMMAND="find . -printf \"%P\\\n\"" # hidden files, too
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # mac osx
    # TODO: better find query
    export FZF_DEFAULT_COMMAND="find ."
fi

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# TODO: make sure bash aspect works across all platforms
if [ -f ~/.profile ]; then
    . ~/.profile
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
. "$HOME/.cargo/env"
