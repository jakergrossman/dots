# dotfiles
collection of system configuration files

loosely based on [Greg Hurrell's dotfile structure](https://github.com/wincent/wincent)

## dependencies
- [ruby](https://www.ruby-lang.org/en/) to run the installation script

## usage
install by running `bootstrap.rb`:

    ruby bootstrap.rb

`aspects.json` contains a list of aspects for each supported platform. for
every aspect on a platform, the corresponding `aspect.rb` for that aspect is run.
for example, for the `dotfiles` aspect, `bootstrab.rb` will execute the script
`aspects/dotfiles/aspect.rb`. each aspect is run in isolation, so local variables
and definitions do not leak into the global namespace.

to assist with common tasks, a meta-aspect named `meta` is always included. It defines
common functions for creating aspects. the most important is `task(desc, callback)`, which
takes a description for the task logger and a callback to run for that task (backing up, creating
directories, etc).
