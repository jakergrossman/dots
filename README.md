# dotfiles
my system configuration files

## packages
- fish: [fish](https://fishshell.com) configuration
- shell: shell environment configuration
  - minimal `bash`
  - tmux
  - git
- vim: [neovim](https://github.com/neovim/neovim) and [vim](https://github.com/vim/vim) configuration.
- emacs: [emacs](https://www.gnu.org/software/emacs/) configuration.

## submodules
Some configuration options depend on git submodules. Either use `--recursive` when cloning
or run `git submodule init && git submodule update` in the root of the repository after cloning.

## installation using gnu stow
```console
$ stow package1 package2 ...
```
