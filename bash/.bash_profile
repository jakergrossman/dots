# load .bashrc
[[ -f ~/.bashrc ]] && source ~/.bashrc

# start X (and therefore XMonad) on login
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
