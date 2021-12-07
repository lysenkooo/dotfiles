#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

softwareupdate --install-rosetta

defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0

tmutil addexclusion ~/Applications
tmutil addexclusion ~/Downloads
tmutil addexclusion ~/Library/Caches/com.docker.docker

if [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew doctor
brew bundle

ansible-playbook playbook.yml
