# dotfiles
my system configuration files

## packages
- fish: [fish](https://fishshell.com) configuration
- shell: shell environment configuration
  - minimal `bash`
  - git
- tmux: terminal multiplexer configuration
- vim: [neovim](https://github.com/neovim/neovim) and [vim](https://github.com/vim/vim) configuration
- sway: [sway window manager](https://swaywm.org) configuration

## submodules
Some configuration options depend on git submodules. Either use `--recursive` when cloning
or run `git submodule init && git submodule update` in the root of the repository after cloning.

## installation using gnu stow
```console
$ stow package1 package2 ...
```

## license
This work is dual-licensed under the following licenses:
- [The Unlicense](https://opensource.org/license/unlicense/)
- [ISC](https://opensource.org/license/isc-license-txt/)
