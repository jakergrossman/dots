function fish_greeting
    if command -vq fortune
        set_color -i -d
        echo
        fortune | sed "s/^/  /"
        echo
        set_color normal
    else
        set_color -i -d
        echo "  it's a little too quiet..."
        set_color normal
    end
end
