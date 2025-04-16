#!/bin/bash -ex

DT=$(date -u '+%y%m%d%H%M%S')
echo "Run: ${DT}"

rsync -av --delete --exclude .git "$HOME/Yandex.Disk.localized/backup/" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.backup/"
rsync -av --delete --exclude .git "$HOME/.mackup/" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.mackup/"

# brew
cd ~/.dotfiles
/opt/homebrew/bin/brew bundle dump -d -f --describe --mas --file brew/Brewfile.mas
/opt/homebrew/bin/brew bundle dump -d -f --describe --cask --file brew/Brewfile.cask
/opt/homebrew/bin/brew bundle dump -d -f --describe --formula --file brew/Brewfile.brew
git add .
git commit -a -m WIP
git push

# mackup
mackup backup -f
mackup uninstall -f
cd ~/.mackup
git add .
git commit -a -m "${DT}" || true

