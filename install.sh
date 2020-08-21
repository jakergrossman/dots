#!/bin/bash

# check for arguments
if [ "$#" -eq 0 ]; then
    # show output as if -h flag was set
    ./$0 "-h"
    exit
fi

# get list of directories in the current directory (modules)
modules=$(find . -mindepth 1 -maxdepth 1 -type d | sed 's/^\.\///' | grep '^[^.].*')

# check for options
while getopts "hvfdnm" opt; do
    case ${opt} in
        h  ) # help flag
            echo "Usage: ./install.sh [-h|-m] [-vdn] module1 module2 ..."
            echo "    -h        Show this help dialog."
            echo "    -v        Show verbose output."
            echo "    -f        Force execution of action"
            echo "    -d        Remove modules instead of installing them."
            echo "    -n        Print the actions that would be executed,"
            echo "              but do not execute them."
            echo "    -m        Print a list of modules."
            exit
            ;;
        f  ) # force link
            force=true
            ;;
        v  ) # verbose output
            verbose=true
            ;;
        d  ) # delete symlinks
            delete=true
            ;;
        n  ) # only print the actions that would be executed
            intend=true
            ;;
        m  ) # module list
            echo "$modules"
            exit
    esac
done

# shift options out of $@
shift $((OPTIND - 1))

for module in "$@"
do
    # validate module name
    if [[ ! "$modules" =~ "$module" ]]; then
        echo "$module is not a valid module. valid modules:"
        ./$0 "-m"
        exit
    fi

    # prompt for Git submodule setup if vim
    if [ "$module" = "vim" ]; then
        submodule_files=$(find vim/.vim/pack/bundle/opt/**/* -type f > /dev/null 2>&1)

        if [ "$?" -eq 1 ]; then
            # prompt user install Git submodules
            while true; do
                read -p "Do you want to install Git submodules? (Y/n): " response
                case $response in
                    [Yy]* ) # install Git submodules
                        git submodule init
                        git submodule update
                        break
                        ;;
                    [Nn]* ) # don't install Git submodules
                        break
                        ;;
                    *     ) # prompt again
                        continue
                        ;;
                esac
            done
        fi
    fi

    if [ "$delete" ]; then
        echo "unlinking $module"
    else
        echo "linking $module"
    fi

    for file in $(find "$module" -type f -print)
    do
        file_dest=$HOME/${file#$module/}
        if [ ! "$intend" ]; then
            if [ "$delete" ]; then
                # make sure this is a symlink, not a file
                if [ -L "$file_dest" ]; then
                    unlink "$file_dest"
                fi
            else
                # check that there is neither a file nor a link already,
                # or if the force flag is enabled
                if [ ! "$force" ] && ([ -f "$file_dest" ] || [ -L "$file_dest" ]); then
                    # if so, and verbosity is enabled, tell the user
                    if [ "$verbose" ]; then
                        echo "$file_dest already exists, skipping"
                    fi

                    continue
                fi

                # make dir if it doesn't exist
                mkdir --parents $(dirname $HOME/"${file#$module/}")

                if [ "$force" ]; then
                    ln -sf "$(pwd)/$file" "$file_dest"
                else
                    ln -s "$(pwd)/$file" "$file_dest"
                fi
            fi
        fi

        if [ "$verbose" ]; then
            if [ "$delete" ]; then
                echo "unlink $file_dest"
            else
                echo "$file -> $file_dest"
            fi
        fi
    done

    echo ""
done
