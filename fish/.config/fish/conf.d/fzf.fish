# determine what to use for find
set -l FIND "find . -type f -not -path '*/\.git/*' -printf '%P\n'"
if type -q rg
    set -l FIND 'rg --hidden --files .'
end

set -x FZF_DEFAULT_COMMAND $FIND
set -x FZF_CTRL_T_COMMAND $FIND
set -x FZF_DEFAULT_OPTS "\
    --color=fg:#$jg_black,bg:#$jg_background,hl:#$jg_orange \
    --color=fg+:#$jg_black,bg+:#$jg_selection,hl+:#$jg_red \
    --color=info:#$jg_orange,prompt:#$jg_green,pointer:#$jg_pink \
    --color=marker:#$jg_pink,spinner:#$jg_orange,header:#$jg_comment" \
