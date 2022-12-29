function mkcd --description "Recursively make directories, then `cd` to the last one"
    if test (count $argv) -lt 1
        echo "mkcd: expected at least one directory" 2>&1
        echo "usage: mkcd DIRECTORY..." 2>&1
        return 1
    end

    for n in $argv
        mkdir -p $n
    end

    # n is implicitly saved from the loop
    cd $n
end
