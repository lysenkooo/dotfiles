#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

defaults write -g NSRequiresAquaSystemAppearance 1
defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew upgrade
    brew doctor
    brew tap caskroom/versions
fi

brew ls --versions python3 > /dev/null || brew install python3

if [[ ! -x /usr/local/bin/ansible ]]; then
    echo "Installing ansible..."
    pip3 install --user ansible
fi

ansible-playbook playbook.yml
