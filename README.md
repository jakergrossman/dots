
# dotfiles
collection of system configuration files

## packages
- dotfiles: creates symlinks in $HOME to the files in this aspect
- nvim: Configures [neovim](https://github.com/neovim/neovim)
- emacs: Configures [emacs](https://www.gnu.org/software/emacs/)

## dependencies
- [git](https://git-scm.com/) to clone the repository
- optionaly: [GNU Stow](https://www.gnu.org/software/stow/) for automatic installation

## installation using GNU Stow (*nix/MacOS)
```console
$ stow package1 package2 ...
```

## installation using PowerShell (Windows 7+)
Right click `deploy.ps1`, "Run With Powershell". The script will automatically try to elevate
it's privileges and deploy MANIFEST.