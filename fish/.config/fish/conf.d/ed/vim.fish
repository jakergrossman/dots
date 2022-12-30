# fallback to vim if nvim is not found
set vi vim
test -x (command -v nvim); and set vi nvim

abbr -a vim $vi # nvim if found

abbr -a e $vi

set -x EDITOR $vi
