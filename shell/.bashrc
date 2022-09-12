# if not interactive, don't do anything
[[ $- != *i* ]] && return

# be nice to sysadmins
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
fi

# history management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls"
