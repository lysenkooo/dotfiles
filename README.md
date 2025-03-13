# macOS dotfiles

```sh
brew bundle dump -f --describe --mas --file brew/Brewfile.mas
brew bundle dump -f --describe --cask --file brew/Brewfile.cask
brew bundle dump -f --describe --formula --file brew/Brewfile.brew
```

```sh
mackup backup -f && mackup uninstall
```

## Init

```sh
rm -rf ~/.ssh
ln -s ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/ssh ~/.ssh
cp '~/Mobile Documents/com~apple~CloudDocs/.backup/zshrc_custom' ~/.zshrc_custom
cp -r

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
brew bundle --file brew/Brewfile.formula
brew bundle --file brew/Brewfile.cask
brew bundle --file brew/Brewfile.mas
```

Python:
```sh
mise use -g python
pip install --upgrade pip
```

NodeJS:
```sh
mise use -g node@20
npm install -g yarn
```

Ruby:
```sh
mise use -g ruby
gem update --system
```

Install pip packages:
```sh
pip install jmespath neovim ansible ansible-vault ansible-lint awscli mackup
```

Restore mackup configs:
```sh
mackup restore
```

### Vim Plugins

* Open `vim` and run `:VundleInstall`.
* Open `nvim` and run `:PlugInstall`.

### Cron

Use `crontab -e` to add:
```
0 * * * * date >> /tmp/cron.log 2>&1

1 * * * * rsync -av --exclude .git "$HOME/Yandex.Disk.localized/backup/" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.backup/" >> /tmp/cron-backup.log 2>&1

2 * * * * sh -c -l "cd ~/.dotfiles && /opt/homebrew/bin/brew bundle dump -d -f --describe --mas --file brew/Brewfile.mas" >> /tmp/cron-dotfiles.log 2>&1
3 * * * * sh -c -l "cd ~/.dotfiles && /opt/homebrew/bin/brew bundle dump -d -f --describe --cask --file brew/Brewfile.cask" >> /tmp/cron-dotfiles.log 2>&1
4 * * * * sh -c -l "cd ~/.dotfiles && /opt/homebrew/bin/brew bundle dump -d -f --describe --formula --file brew/Brewfile.brew" >> /tmp/cron-dotfiles.log 2>&1
5 * * * * sh -c -l "cd ~/.dotfiles && git add . && git commit -a -m WIP && git push" >> /tmp/cron-dotfiles.log 2>&1

6 * * * * sh -c "$HOME/.local/share/mise/installs/python/latest/bin/mackup backup -f && $HOME/.local/share/mise/installs/python/latest/bin/mackup uninstall -f" >> /tmp/cron-mackup.log 2>&1
7 * * * * sh -c "cd ~/.mackup && git add . && git commit -a -m WIP" >> /tmp/cron-mackup.log 2>&1
8 * * * * rsync -av --delete --exclude .git "$HOME/.mackup/" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.mackup/" >> /tmp/cron-mackup.log 2>&1

9 * * * * find -E Eng -type d -iregex '.+\/(node_modules|tmp|log)$' -prune -print -exec tmutil addexclusion {} \; >> /tmp/cron-tmutil.log 2>&1
```

Root:

```
* * * * * sudo hidutil property --matching '{"ProductID":0x29a}' --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}'
```

### Time Machine with SSD

```sh
hdiutil create -type SPARSEBUNDLE -fs "HFS+J" -size 300g -volname TM-Air /Volumes/SSD/TM.sparsebundle
open /Volumes/SSD/TM.sparsebundle
sudo tmutil setdestination /Volumes/TM
```

### Proxy Settings

```sh
https://raw.githubusercontent.com/lysenkooo/dotfiles/refs/heads/master/proxy/home-min.conf
https://raw.githubusercontent.com/lysenkooo/dotfiles/refs/heads/master/proxy/home-def.conf
https://raw.githubusercontent.com/lysenkooo/dotfiles/refs/heads/master/proxy/cellar-min.conf
https://raw.githubusercontent.com/lysenkooo/dotfiles/refs/heads/master/proxy/cellar-def.conf
https://raw.githubusercontent.com/lysenkooo/dotfiles/refs/heads/master/proxy/pac.js
```
