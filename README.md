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

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Install Ruby

```sh
ruby-install ruby 3.0.3
ruby-install ruby 2.7.5
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

### Time Machine

```sh
$ crontab -e
```

Add:
```
0 * * * * find ~/Projects -type d -name node_modules -maxdepth 5 -prune -exec tmutil addexclusion {} \; > /dev/null
0 * * * * find ~/Projects -type d -name tmp -maxdepth 5 -prune -exec tmutil addexclusion {} \; > /dev/null
```

Setup Time Machine:

```sh
sudo tmutil setdestination /Volumes/TM
```

### Dump package list

```sh
$ brew bundle dump --describe -f
```
