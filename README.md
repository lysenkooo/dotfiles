# Dotfiles

My Mac OS provision scripts.

## Install

Clone repo and install configuration files:
```
$ rm -rf ~/.ssh
$ ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.ssh ~/.ssh
$ git clone git@github.com:lysenkooo/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./provision.sh
```

* Run `\vim` and run `:VundleInstall`.
* Run `nvim` and run `:PlugInstall`.

### Install Ruby

```sh
ruby-install ruby 3.0.3
ruby-install ruby 2.7.5
gem install --user-install ffi -- --enable-libffi-alloc
```

### Install NodeJS

```sh
arch -x86_64 zsh
arch
nvm install 12.20.0
exit
node -p process.arch
nvm use 12.20.0
npm install --global yarn
```

Open vim and run `:BundleInstall`.
Open nvim and run `:PlugInstall`.

### Dump package list

```sh
$ brew bundle dump --describe -f
```
