# fallback to vim if nvim is not found
if type -q nvim
    set -x EDITOR nvim
else if type -q vim
    set -x EDITOR vim
else
    set -x EDITOR vi
end

abbr -a e $EDITOR
