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

Install Rosetta:
```sh
softwareupdate --install-rosetta
```

```sh
pyenv install 3.10.6
pyenv global 3.10.6
eval "$(pyenv init -)"
python -m pip install --upgrade pip
pip install neovim jmespath ansible ansible-vault ansible-lint awscli mackup
mackup restore
```

```sh
nvm install 16
nvm alias default 16
nvm use 16
npm install -g yarn sort-package-json
```

```sh
ruby-install --latest ruby -- --enable-shared
ruby-install ruby 2.7 -- --enable-shared
```

```sh
gem update --system
gem install solargraph
```

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Cron

```sh
crontab -e
```

Add:
```
0 * * * * bash -l -c 'cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles && git commit -a -m WIP && git push' > /dev/null 2> /dev/null
1 * * * * find -E ~/Projects -type d -iregex '.+\/(tmp|log|node_modules)$' -prune -exec tmutil addexclusion {} \; > /dev/null
```

### Time Machine

```sh
hdiutil create -type SPARSEBUNDLE -fs "HFS+J" -size 200g -volname TM-Air /Volumes/T5/TM_Air.sparsebundle
open /Volumes/T5/TM_Air.sparsebundle
sudo tmutil setdestination /Volumes/TM-Air
```

### Dump Settings

```sh
mackup backup
brew bundle dump --mas --describe -f
```

### Change TTL

```sh
echo "net.inet.ip.ttl=65" | sudo tee -a /etc/sysctl.conf
```
