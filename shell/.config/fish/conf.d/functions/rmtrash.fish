function rmtrash --description 'Like `rm`, but move to a trash directory instead'
    argparse \
        'i/interactive'       \
        'r/recursive'         \
        'trash-dir='          \
        'n/dry-run'           \
        'e/empty'             \
        'v/verbose'           \
        'help'                \
        -- $argv

    if test $status -ne 0
        # n unknown option message already printed by argparse
        _echo_err 'Try \'rmtrash --help\' for more information'
        return 1
    end

    if set -q _flag_help[1]
        _rmtrash_usage
        return 0
    end

    # combine short and long options for better conditionals l8r
    if set -q _flag_i; or set -q _flag_interactive; set do_interactive; end
    if set -q _flag_r; or set -q _flag_recursive;   set do_recursive; end
    if set -q _flag_n; or set -q _flag_dry_run;     set do_dry_run;   end
    if set -q _flag_e; or set -q _flag_empty;       set do_empty;     end
    if set -q _flag_v; or set -q _flag_verbose;     set is_verbose;   end

    # default to $HOME/.Trash
    test "$_flag_trash_dir" != ''; and set -l trash_dir (eval echo $_flag_trash_dir)
    or set trash_dir "$HOME/.Trash/"

    if not test -d $trash_dir
        mkdir -p $trash_dir
    end

    if set -q do_empty
        # empty trash folder
        set -l files {$trash_dir}*

        if set -q do_dry_run
            # confirm printing if lots of files
            if test (count $files) -gt 30; and not _get_confirmation 'List all' (count $files) 'files? [y/N] '
                return 1
            end
            for file in $files
                echo "remove '$file'"
            end
        else
            for file in $files
                rm -r $file (set -q do_interactive; and echo '-i')
                if set -q is_verbose
                    echo "removed $file"
                end
            end
        end
    else
        if test (count $argv) -eq 0
            _echo_err 'rmtrash: Missing operand'
            _echo_err 'Try \'rmtrash --help\' for more information'
            return 1
        end

        # move to trash
        for file in $argv
            if not test -e $file
                _echo_err "rmtrash: cannot remove '$file': No such file or directory"
                continue
            end

            set -l type (test -d $file; and echo 'directory'; or echo 'file')

            if test $type = 'directory'; and not set -q do_recursive
                _echo_err "rmtrash: cannot remove '$file': Is a directory"
                continue
            end

            if set -q do_interactive; and not _get_confirmation "rmtrash: remove $type '$file'?: "
                continue
            end

            # if there is already a file with the same name,
            # prepend underscores until that is no longer the case
            set -l destination $file
            while test -e $trash_dir$destination
                set destination _$destination
            end

            if not set -q do_dry_run
                mv $file $trash_dir$destination
            end

            if set -q do_dry_run; or set -q is_verbose
                echo "Moved '$file' to '$trash_dir$destination'"
            end
        end
    end
end

# print prompt and read whether response is affirmative
function _get_confirmation
    if string match -q -r '^[yY]' (read -l -P "$argv")
        return 0
    else
        return 1
    end
end

function _echo_err
    echo $argv 1>&2
end

function _rmtrash_usage
    _echo_err 'Usage: rmtrash [OPTION]... [FILE]...'
    _echo_err 'Softer version of `rm`, moving "deleted" files to a trash directory instead'.
    _echo_err
    _echo_err '  -i, --interactive          prompt before every removal'
    _echo_err '  -r, --recursive            remove directories and their contents recursively'
    _echo_err '  -e, --empty                empty the trash directory'
    _echo_err '  -t, --trash-dir=[WHERE]    specify a trash directory other than $HOME/.Trash'
    _echo_err '  -n, --dry-run              list what WOULD be done, without doing it, implies -v'
    _echo_err '  -v, --verbose              explain what is being done'
    _echo_err '      --help                 display this help and exit'
    _echo_err
    _echo_err 'By default, rmtrash does not remove directories.  Use the --recursive (-r)'
    _echo_err 'option to remove each listed directory, too, along with all of its contents.'
    _echo_err
    _echo_err 'Using --empty (-e) is a destructive action, and is essentially a passthrough to `rm`.'
    _echo_err
    _echo_err 'If a file with the same name already exists in the trash directory,'
    _echo_err 'underscores are prepended to the file name until it is unique.'
end
