# Dotfiles

Mac OS provision scripts.

## Install

Clone repo and install configuration files:
```sh
rm -rf ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.ssh ~/.ssh
chmod 0600 ~/.ssh/id_rsa ~/.ssh/*.pem
git clone git@github.com:lysenkooo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./provision.sh
```

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Install Python

```sh
pyenv install 3.10.6
python -m pip install --upgrade pip
pip3 install neovim jmespath ansible ansible-vault ansible-lint awscli
```

### Install Ruby

```sh
ruby-install ruby 2.7.6
ruby-install ruby 3.1.2
```

### Install NodeJS

```sh
nvm install 16
npm install -g yarn sort-package-json
```

### Time Machine

```sh
crontab -e
```

Add:
```
0 * * * * bash -l -c 'cd ~/.dotfiles && git commit -a -m WIP && git push' > /dev/null 2> /dev/null
1 * * * * find ~/Projects -type d -name tmp -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
2 * * * * find ~/Projects -type d -name node_modules -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
3 * * * * find ~/Fohlio -type d -name tmp -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
4 * * * * find ~/Fohlio -type d -name node_modules -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
```

Setup Time Machine:

```sh
sudo tmutil setdestination /Volumes/TM
```

### Dump package list

```sh
brew bundle dump --mas --describe -f
```
