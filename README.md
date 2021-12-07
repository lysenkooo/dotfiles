# Dotfiles

My macbook provision.

## Install

```
$ rm -rf ~/.ssh
$ ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.ssh ~/.ssh
$ git clone git@github.com:lysenkooo/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./provision.sh
```

```sh
arch -x86_64 zsh
arch
nvm install 12.20.0
exit
node -p process.arch
arch
nvm use 12.20.0
npm install --global yarn
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
gem install --user-install ffi -- --enable-libffi-alloc
```

Open vim and run `:BundleInstall`.
Open nvim and run `:PlugInstall`.

## Dump

```sh
$ brew bundle dump --describe -f
```
