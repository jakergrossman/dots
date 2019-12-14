# dotfiles
```
git     > git config and aliases
vim     > vim editor config
nvim    > nvim editor config (requires that the vim config be installed)
tmux    > terminal multiplexer
zsh     > oh-my-zsh plugins and themes, shell settings
```

# usage
i use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles

```
git clone https://github.com/jakergrossman/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

in order to use this vim configuration, you must first initialize the submodules for the plugins
with the following commands:

```
git submodule init
git submodule update
```

then, install selected modules with the following command

```
stow vim # and any other packages
```

