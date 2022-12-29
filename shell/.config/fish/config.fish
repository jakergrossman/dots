# just bootstrap conf.d/
set -x fish_function_path "$__fish_config_dir/conf.d/functions" $fish_function_path
set -x fish_complete_path "$__fish_config_dir/conf.d/completions" $fish_complete_path

set modules \
    (find $__fish_config_dir/conf.d -maxdepth 1 -mindepth 1 -type d -not -name "completions" -not -name "functions")

for m in $modules
    source_module (basename $m)
end
