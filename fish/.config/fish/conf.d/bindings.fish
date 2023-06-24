if ! test -z "$TMUX"
    # tmux isn't loading these, working around it for now
    for f in $__fish_config_dir/functions/*
        source $f
    end
end

fzf_key_bindings

# tmux-sessionizer when command line is empty, else fill completion
bind \cF "[ -z (commandline) ] && tmux-sessionizer || commandline -f forward-char"
