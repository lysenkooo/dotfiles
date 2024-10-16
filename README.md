# macOS dotfiles

```sh
rm -rf ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/ssh ~/.ssh
ln -s /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/zshrc-custom ~/.zshrc-custom
chmod 0600 ~/.ssh/*
git clone git@github.com:lysenkooo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
INIT=1 provision.sh
```

## Additional steps

Install Rosetta:
```sh
softwareupdate --install-rosetta
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

```sh
crontab -e
```

Add:
```
1 * * * * find -E ~/d -type d -iregex '.+\/(tmp|log|node_modules)$' -prune -exec tmutil addexclusion {} \; >> /tmp/cron-tmutil.log 2>&1
2 * * * * rsync -av --delete --exclude '.git' '/Users/ccbe/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles/' '/Users/ccbe/.dotfiles' >> /tmp/cron-rsync.log 2>&1
3 * * * * bash -c "cd '/Users/ccbe/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles' && git commit -a -m WIP && git push" >> /tmp/cron-dotfiles.log 2>&1
```

### Time Machine with SSD

```sh
hdiutil create -type SPARSEBUNDLE -fs "HFS+J" -size 300g -volname TM-Air /Volumes/SSD/TM.sparsebundle
open /Volumes/SSD/TM.sparsebundle
sudo tmutil setdestination /Volumes/TM
```

### Dump Settings

```sh
mackup backup
brew bundle dump --mas --describe -f
```
