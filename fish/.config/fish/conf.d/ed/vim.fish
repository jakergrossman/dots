# fallback to vim if nvim is not found
if type -q nvim
    set vi nvim
else
    set vi vim
end

abbr -a vim $vi # nvim if found

abbr -a e $vi

set -x EDITOR $vi
