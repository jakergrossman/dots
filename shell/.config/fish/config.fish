set vi vim
test -x (command -v nvim); and set vi nvim

abbr -a vim $vi # nvim if found
abbr -a e $vi
abbr -a g git
abbr -a gs git status
abbr -a gr gitroot

# fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set -x EDITOR $vi
set -x FZF_DEFAULT_OPTS '--height 20%'

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "

    set_color magenta
    echo -n (basename $PWD)

    set_color yellow
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '| '
    set_color normal
end

function fish_greeting
    if test -x /usr/bin/ufetch
        ufetch
    end
end
