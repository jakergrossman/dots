# just bootstrap conf.d/
set -x fish_function_path "$__fish_config_dir/conf.d/functions" $fish_function_path
set -x fish_complete_path "$__fish_config_dir/conf.d/completions" $fish_complete_path
