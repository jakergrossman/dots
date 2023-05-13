function fish_greeting
    set_color $material_gray
    echo -n 'UPTIME: '
    set_color normal
    uptime -p | string replace 'up ' '' | rainbow

    echo '--------------------------' | rainbow
end
