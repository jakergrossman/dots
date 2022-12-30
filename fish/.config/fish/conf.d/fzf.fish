# determine what to use for find
set -l FIND "find . -type f -not -path '*/\.git/*' -printf '%P\n'"
if type -q rg
    set -l FIND 'rg --hidden --files .'
end

set -x FZF_DEFAULT_COMMAND $FIND
set -x FZF_CTRL_T_COMMAND $FIND
set -x FZF_DEFAULT_OPTS '--height 20%'
