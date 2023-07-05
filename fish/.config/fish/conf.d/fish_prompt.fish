function fish_prompt
    set laststatus $status

    set user_color $jg_pink
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

    set prompt_status (__fish_print_pipestatus "[" "] " "|" "$(set_color --bold $jg_red)" "" $laststatus)

    set njobs (jobs | count)
    switch $njobs
        case 0
            set job_status ""
        case 1
            set job_status " ⚡"
        case '*'
            set job_status " ⚡($njobs)"
    end


    # FIRST LINE
    echo -s -n \
        (set_color normal) "$prompt_status" \
        (set_color $user_color)             "$USER"             \
        (set_color $jg_red)           "::"                 \
        (set_color $jg_pink)          (prompt_hostname)   \
        (set_color normal)                  " "                 \
        (set_color $jg_magenta)    "$abbr_dir"         \
        (set_color $jg_green)     (printf '%s' (__fish_vcs_prompt)) \
        (set_color normal)                  " "                 \
        (set_color $jg_comment)          "["(date "+%H:%M")"]" \
        (set_color $jg_yellow)        "$job_status" \
        (set_color normal) " $suffix "
end
