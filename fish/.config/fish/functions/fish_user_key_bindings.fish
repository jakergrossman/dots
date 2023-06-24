function fish_user_key_bindings
    fzf_key_bindings

    # tmux-sessionizer when command line is empty, else fill completion
    bind \cF "[ -z (commandline) ] && tmux-sessionizer || commandline -f forward-char"
end
