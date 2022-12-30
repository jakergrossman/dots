function fish_prompt
    set laststatus $status

    set user_color $material_pink
    set suffix "\$"
    if fish_is_root_user
        set user_color $material_error
        set suffix "#"
    end

    set abbr_dir (realpath --relative-base "$HOME/" --strip (pwd))
    if test (pwd) = "$HOME"
        # otherwise, output is "."
        set abbr_dir "$HOME"
    end

    set prompt_status (__fish_print_pipestatus "[" "] " "|" "$(set_color --bold $material_red)" "" $laststatus)

    # FIRST LINE
    echo -s \
        (set_color $user_color)             "$USER"             \
        (set_color $material_red)           "@"                 \
        (set_color $material_pink)          (prompt_hostname)   \
        (set_color normal)                  " "                 \
        (set_color $material_darkpurple)    "$abbr_dir"         \
        (set_color $material_darkgreen)     (printf '%s' (__fish_vcs_prompt)) \
        (set_color normal)                  " "                 \
        (set_color $material_gray)          "["(date "+%H:%M")"] "

    # SECOND LINE
    set_color normal
    echo -s -n "$prompt_status" "$suffix "
end
