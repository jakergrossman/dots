# vim: et ts=4 sts=4 sw=4

function fish_prompt
    set laststatus $status

    set user_color $jg_br_red
    set suffix "\$"
    if fish_is_root_user
        set user_color $jg_red
        set suffix "#"
    end

    set abbr_dir (realpath --relative-base "$HOME/" --strip (pwd))
    if test (pwd) = "$HOME"
        # otherwise, output is "."
        set abbr_dir "$HOME"
    end

    set status_color "$(set_color $jg_white --background $jg_red)"
    set prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "" $laststatus)

    set njobs (jobs | count)
    switch $njobs
        case 0
            set job_status ""
        case 1
            set job_status " ⚡"
        case '*'
            set job_status " ⚡($njobs)"
    end

    if ! test -z "$prompt_status"
        echo -e -s -n \
            (set_color --background $jg_red) \
            "$prompt_status" \
            (set_color normal) \
            " "
    end

    echo -e -s -n \
        (set_color normal --background $user_color) "$USER"                             \
        (set_color normal --background $jg_br_red) "::" \
        (set_color normal --background $jg_br_red)    (prompt_hostname)                 \
        (set_color normal) " " \
        (set_color normal --background $jg_br_magenta) "$abbr_dir"                         \
        (set_color normal) " " \
        (set_color normal --background $jg_br_green)   (fish_vcs_prompt | cut -c 2-)   \
        (set_color normal normal)      "\n"                                \
        (set_color normal --background $jg_br_orange) "["(date "+%H:%M")"]"               \
        (set_color normal --background $jg_br_yellow)  "$job_status"                       \
        (set_color normal)      " $suffix "
end
