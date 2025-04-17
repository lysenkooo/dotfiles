#!/bin/bash -ex

DT=$(date -u '+%y%m%d%H%M%S')
SD=$(dirname "$0")
SN=$(basename "$0")

rsync -av --delete --exclude .git "$HOME/.dotfiles" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.dotfiles/"
rsync -av --delete --exclude .git "$HOME/.mackup/" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.mackup/"

echo "> Brew"
cd "$SD"
/opt/homebrew/bin/brew bundle dump -d -f --describe --mas --file brew/Brewfile.mas
/opt/homebrew/bin/brew bundle dump -d -f --describe --cask --file brew/Brewfile.cask
/opt/homebrew/bin/brew bundle dump -d -f --describe --formula --file brew/Brewfile.brew
git add .
git commit -a -m "${DT}" || true
git push

echo "> Mackup"
mackup backup -f
mackup uninstall -f
cd ~/.mackup
git add .
git commit -a -m "${DT}" || true

