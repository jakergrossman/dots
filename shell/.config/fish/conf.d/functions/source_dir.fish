function source_dir --description "Source all fish configuration snippets in a directory."
    argparse --min-args=1 r/recursive -- $argv
    or return 1

    set -q _flag_recursive
    or set recurse_str -maxdepth 1

    for arg in $argv
        set sources (find $arg $recurse_str  -name "*.fish")
        for s in $sources
            source $s
        end
    end
end
