# vim: et ts=4 sts=4 sw=4

function fish_prompt
    set laststatus $status

    set -l brred (set_color brred)
    set -l brblue (set_color brblue)
    set -l green (set_color brgreen)
    set -l normal (set_color normal)
    set -l yellow (set_color yellow)
    set -l bryellow (set_color bryellow)
    set -l brblack (set_color brblack)
    set -l brpurple (set_color brpurple)

    # datetime / separator line
    set -l date (date "+%H:%M:%S")
    set -l sep (string pad -r --char='-' --width=80 -- "- ($date) -")
    echo -e "$brblack$sep$normal"

    # main line
    set host "$(prompt_hostname)"

    set caret '$'
    set caret_color $yellow
    if fish_is_root_user
        set caret '#'
        set caret_color $brred
    end

    set prompt_status (__fish_print_pipestatus "[" "]" "|" "$(set_color red)" "" "$laststatus")
    echo -e -n "$brblue$host"
    echo -e -n "$normal:"
    echo -e -n "$yellow$USER"
    echo -e -n "$normal "

    set -l pwd $(prompt_pwd --dir-length=8 --full-length-dirs=3)
    set -l vcs $(fish_vcs_prompt | cut -c 2-)

    echo -e -n "$bryellow$pwd$normal "
    test -n "$vcs" && echo -e -n "$brpurple$vcs$normal "
    test -n "$prompt_status" && echo -e -n "$prompt_status "
    test -n "$caret" && echo -e -n "$caret_color$caret$normal "
end
