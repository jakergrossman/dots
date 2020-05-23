# dotfiles
```
fonts       > custom fonts
git         > git config and aliases
vim         > vim editor config
tmux        > terminal multiplexer
zsh         > oh-my-zsh plugins and themes, shell settings
kitty       > kitty terminal emulator settings
```

# usage
i use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles

```
git clone https://github.com/jakergrossman/jakergrossman.git ~/jakergrossman
cd ~/dotfiles
```

in order to setup the required submodules, run the following commands:

```
git submodule init
git submodule update
```

then, install selected modules with the following command

```
stow vim # and any other packages
```
