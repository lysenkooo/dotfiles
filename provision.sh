#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

echo -e "#!/bin/sh\necho \"Xcode 11.4.1\\nBuild version 11E503a\"\nexit 0" > /usr/local/bin/xcodebuild

sudo xcodebuild -license accept

defaults write -g NSRequiresAquaSystemAppearance 1
defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0

tmutil addexclusion ~/Applications
tmutil addexclusion ~/Downloads
tmutil addexclusion ~/Library/Caches/com.docker.docker
find ~/Projects -type d -name tmp -maxdepth 5 -prune -exec tmutil addexclusion {} \; > /dev/null
find ~/Projects -type d -name node_modules -maxdepth 5 -prune -exec tmutil addexclusion {} \; > /dev/null

if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew doctor
brew bundle

if [[ ! -x /usr/local/bin/ansible ]]; then
    echo "Installing ansible..."
    pip3 install --user ansible
fi

ansible-playbook playbook.yml
