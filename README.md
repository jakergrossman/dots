# dotfiles

    fonts       > custom fonts
    git         > git config and aliases
    vim         > vim editor config
    tmux        > terminal multiplexer
    zsh         > oh-my-zsh plugins and themes, shell settings
    kitty       > kitty terminal emulator settings

# usage
i use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles

cloning:

    git clone https://github.com/jakergrossman/jakergrossman.git ~/jakergrossman
    cd ~/jakergrossman

then, to install packages

    stow vim
    stow zsh
    ...

*note*: the following packages require initializing git submodules:
* vim
* zsh

to install git submodules

    git submodule init
    git submodule update
