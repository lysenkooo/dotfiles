# Dotfiles

Mac OS provision scripts.

## Install

Install ssh keys:
```sh
rm -rf ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.ssh ~/.ssh
chmod 0600 ~/.ssh/*
```

Clone repo and install configuration files:
```sh
git clone git@github.com:lysenkooo/dotfiles.git ~/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles
cd ~/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles
./provision.sh
```

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Install Python

```sh
pyenv install 3.10.6
python -m pip install --upgrade pip
pip3 install neovim jmespath ansible ansible-vault ansible-lint awscli mackup
```

### Install Ruby

```sh
ruby-install ruby 2.7.6
ruby-install ruby 3.1.2
```

### Install NodeJS

```sh
nvm install 16
nvm alias default 16
nvm use 16
npm install -g yarn sort-package-json
```

### Time Machine

```sh
crontab -e
```

Add:
```
0 * * * * bash -l -c 'cd "~/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles" && git commit -a -m WIP && git push' > /dev/null 2> /dev/null
1 * * * * find ~/Projects -type d -name tmp -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
2 * * * * find ~/Projects -type d -name node_modules -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
3 * * * * find ~/Fohlio -type d -name tmp -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
4 * * * * find ~/Fohlio -type d -name node_modules -prune -maxdepth 10 -exec tmutil addexclusion {} \; > /dev/null
```

### Time Machine

```sh
hdiutil create -type SPARSEBUNDLE -fs "HFS+J" -size 200g -volname TM-Air /Volumes/T5/TM_Air.sparsebundle
open /Volumes/T5/TM_Air.sparsebundle
sudo tmutil setdestination /Volumes/TM-Air
```

### Dump settings

```sh
mackup backup
brew bundle dump --mas --describe -f
```

### Change TTL

```sh
echo "net.inet.ip.ttl=65" | sudo tee -a /etc/sysctl.conf
```
