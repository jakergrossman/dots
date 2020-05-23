# set editor to vim
set EDITOR=vim
# if stack is installed
if [ -x "$(which stack)" ]; then
    alias ghci="stack ghci"
fi

# create new note
note() {
    vim "+Note $*"
}

# change default fzf command to show hidden files
export FZF_DEFAULT_COMMAND='find -L'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
if [ -x "$(which fzf-tmux)" ]; then
    fe() {
      local files
      IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
      [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
    }
fi

# fd [FUZZY PATTERN] - cd to the selected directory
if [ -x "$(which fzf)" ]; then
    fd() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
                      -o -type d -print 2> /dev/null | fzf +m) &&
      cd "$dir"
    }
fi

