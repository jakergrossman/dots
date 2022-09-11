
# dotfiles
collection of system configuration files

## packages
- dotfiles: creates symlinks in $home to the files in this aspect
- shell: configures shell environment
  - [fish](https://fishshell.com) configuration
  - minimal `bash` configuration
  - tmux
  - git
- vim: configures [neovim](https://github.com/neovim/neovim) and [vim](https://github.com/vim/vim).
- emacs: configures [emacs](https://www.gnu.org/software/emacs/)

## dependencies
- [git](https://git-scm.com/) to clone the repository
- optionaly: [gnu stow](https://www.gnu.org/software/stow/) for automatic installation

## installation using gnu stow
```console
$ stow package1 package2 ...
```
