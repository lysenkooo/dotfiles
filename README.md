# macOS dotfiles

## Update the dump

```sh
brew bundle dump -f --describe --mas --file brew/Brewfile.mas
brew bundle dump -f --describe --cask --file brew/Brewfile.cask
brew bundle dump -f --describe --formula --file brew/Brewfile.brew
```

```sh
mackup backup
```

## Init

```sh
rm -rf ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/ssh ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/zshrc-custom ~/.zshrc-custom
chmod 0600 ~/.ssh/*
git clone git@github.com:lysenkooo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
INIT=1 provision.sh
```

Install Rosetta:
```sh
softwareupdate --install-rosetta
```

Brew:
```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
```

Bundle:
```sh
cd brew
brew bundle
```

```sh
mise use -g python
pip install --upgrade pip
pip install jmespath neovim ansible ansible-vault ansible-lint awscli mackup
```

```sh
mise use -g node@20
npm install -g yarn
```

```sh
mise use -g ruby
gem update --system
```

```sh
mackup restore
```

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Cron

Use `crontab -e` to add:
```
1 * * * * bash -c "cd ~/.dotfiles/brew && brew bundle dump -f --describe --mas --file brew/Brewfile.mas" >> /tmp/cron-dotfiles.log 2>&1
2 * * * * bash -c "cd ~/.dotfiles/brew && brew bundle dump -f --describe --cask --file brew/Brewfile.cask" >> /tmp/cron-dotfiles.log 2>&1
3 * * * * bash -c "cd ~/.dotfiles/brew && brew bundle dump -f --describe --formula --file brew/Brewfile.brew" >> /tmp/cron-dotfiles.log 2>&1
4 * * * * bash -c "cd ~/.dotfiles && git commit -a -m WIP && git push" >> /tmp/cron-dotfiles.log 2>&1
5 * * * * find -E ~/d -type d -iregex '.+\/(tmp|log|node_modules)$' -prune -exec tmutil addexclusion {} \; >> /tmp/cron-tmutil.log 2>&1
```

### Time Machine with SSD

```sh
hdiutil create -type SPARSEBUNDLE -fs "HFS+J" -size 300g -volname TM-Air /Volumes/SSD/TM.sparsebundle
open /Volumes/SSD/TM.sparsebundle
sudo tmutil setdestination /Volumes/TM
```
