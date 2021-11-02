# Hello

See my homepage http://lysenkooo.ru

## Install

```
$ cd /Users/dlysenko/Library/Mobile Documents/com~apple~CloudDocs
$ git clone git@github.com:lysenkooo/dotfiles.git dotfiles
$ cd dotfiles
$ chmod +x provision.sh
$ ./provision.sh
```

Ensure these lines in `.zprofile`:

```
eval "$(/opt/homebrew/bin/brew shellenv)"

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
```

```sh
ruby-install ruby 3.0.2
ruby-install ruby 2.6.8
```

Open vim and run `:BundleInstall`.
Open nvim and run `:PlugInstall`.

## Dump

```sh
$ rm Brewfile
$ brew bundle dump --describe
```
