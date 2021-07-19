# dotfiles
collection of system configuration files for my Arch machine

## packages
    alacritty   > alacritty terminal emulator
    bash        > shell (.bashrc, .bash_profile, etc.)
    git         > .gitconfig and aliases
    vim         > vim editor
    tmux        > tmux multiplexer
    xfiles      > X11 settings (.xinitrc, etc.)
    xmonad      > xmonad window manager

## dependencies
- [Ruby](https://www.ruby-lang.org/en/) to run the installation script
- [vipe](https://linux.die.net/man/1/vipe) to use $EDITOR to select packages

## installation
executing `install.rb` will run a `git commit` style pager. every line
corresponds to a package to install, write the file once you've made your
selection. then, it creates a symbolic link for each file in a package. the
destination of the symlink is defined in each package's `package.json`. if
the destination is already a symlink, **it will unlink and relink with the new
file**. If the destination is a file or hard link, then it will backup the
existing file before linking with the new file.
