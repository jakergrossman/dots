function rainbow --description "Copy stdin to stdout, with rainbow colors"
    set -l rainbow_colors \
      $material_red $material_orange $material_yellow $material_green $material_blue $material_purple

    set -l rainbow_colors_backup \
      red yellow green blue magenta

    set -l color_pos (random 1 (count $rainbow_colors)) # random starting color
    while read line
        for c in (string split -- "" "$line")
            set_color \
              $rainbow_colors[$color_pos] \
              $rainbow_colors_backup[(math $color_pos % (count $rainbow_colors_backup) + 1)]
            echo -n $c
            set color_pos (math $color_pos % (count $rainbow_colors) + 1)
        end
        echo
    end

    set_color normal
end

