function source_module --description "Source a fish module"
    argparse --min-args=1 -- $argv

    for arg in $argv
        set arg $__fish_config_dir/conf.d/$arg

        test -d $arg
        or break

        test -d $arg/functions
        and set -x fish_function_path $arg/functions $fish_function_path

        test -d $arg/completions
        and set -x fish_complete_path $arg/completions $fish_complete_path

        source_dir $arg
    end
end
