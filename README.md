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
cloning:
```
git clone https://github.com/jakergrossman/jakergrossman.git
cd jakergrossman
```

then, install selected modules with the `install.sh` script:

```
Usage: ./install.sh [-h|-m] [-vdn] module1 module2 ...
    -h        Show this help dialog.
    -v        Show verbose output.
    -d        Remove modules instead of installing them.
    -n        Print the actions that would be executed,
              but do not execute them.
    -m        Print a list of modules.
```
