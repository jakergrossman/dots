# tmux-sessionizer when command line is empty, else fill completion
bind \cF "[ -z (commandline) ] && tmux-sessionizer || commandline -f forward-char"
