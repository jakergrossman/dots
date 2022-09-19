# fallback to vim if nvim is not found
set vi vim
test -x (command -v nvim); and set vi nvim

abbr -a vim $vi # nvim if found
abbr -a e $vi
abbr -a g git
abbr -a gs git status
abbr -a gr gitroot
abbr -a r rmtrash

# fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set -x EDITOR $vi

# determine what to use for find
set -l FIND "find . -type f -not -path '*/\.git/*' -printf '%P\n'"
if type -q rg
    set -l FIND 'rg --hidden --files .'
end

set -x FZF_DEFAULT_COMMAND $FIND
set -x FZF_CTRL_T_COMMAND $FIND
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
    set_color $material_gray brblack
    echo -n "["(date "+%H:%M")"] "

    set_color $material_darkpurple magenta
    echo -n (basename $PWD)

    set_color $material_darkgreen green
    printf '%s ' (__fish_git_prompt)
    set_color $material_red red
    echo -n '| '
    set_color $material_white normal
end

function fish_greeting
    if type -q colorscript
        set -l goodscripts 8 11 14 48 56
        set -l pick (random 1 (count $goodscripts))
        colorscript --exec $goodscripts[$pick]
    end

    set_color $material_gray
    echo -n 'OS:     '
    set_color normal
    lsb_release -ds | rainbow

    set_color $material_gray
    echo -n 'UPTIME: '
    set_color normal
    uptime -p | string replace 'up ' '' | rainbow

    echo '--------------------------' | rainbow
end

# color settings
set  -g  fish_color_error        $material_error
set  -g  fish_color_command      $material_darkblue
set  -g  fish_color_operator     $material_darkcyan
set  -g  fish_color_param        $material_blue
set  -g  fish_color_quote        $material_darkgreen
set  -g  fish_color_end          $material_darkpurple
set  -g  fish_color_cwd          $material_cyan
set  -g  fish_color_escape       $material_orange
set  -g  fish_color_normal       $material_white
set  -g  fish_color_redirection  $material_paleblue
