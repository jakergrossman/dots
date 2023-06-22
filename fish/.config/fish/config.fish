# just bootstrap conf.d/
set -x fish_function_path "$__fish_config_dir/conf.d/functions" $fish_function_path
set -x fish_complete_path "$__fish_config_dir/conf.d/completions" $fish_complete_path

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

if type -q exa
    set ls exa
else
    set ls ls
end
abbr -a l $ls
