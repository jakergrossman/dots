# dotfiles
collection of system configuration files

generally based on [Greg Hurrell's dotfile structure](https://github.com/wincent/wincent)

## aspects

- dotfiles: creates symlinks in $HOME to the files in this aspect
- fzf: [fzf](https://github.com/junegunn/fzf) configuration
- node: Configures [n](https://github.com/tj/n) for node version management
- nvim: Configures [neovim](https://github.com/neovim/neovim)

## dependencies
- [git](https://git-scm.com/) to clone the repository

## usage
aspects are located in the `aspects` directory. Use `install` to install
aspects. you can specify individual aspects to install as arguments:

```sh
./install dotfiles fzf  # install just 'dotfiles' and 'fzf' aspects
./install dotfiles      # install just the 'dotfiles' aspect
./install               # install all aspects for the current platform
```
