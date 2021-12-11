#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

if [[ ! -x "/System/Library/CoreServices/Rosetta 2 Updater.app" ]]; then
    echo "Installing Rosetta..."
    softwareupdate --install-rosetta
fi

if [[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -x ~/.nvm/nvm.sh ]]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
fi

brew update
brew doctor
brew bundle

cd assets && find . -type f -print0 |
while IFS= read -r -d '' line; do
    FILE_DIR=`dirname "$line" | cut -c 3-`
    FILE_PATH=`echo "$line" | cut -c 3-`
    SRC_PATH="$(pwd)/$FILE_PATH"
    DST_PATH="$HOME/$FILE_PATH"

    if [ ! -z "$FILE_DIR" ]; then
        DST_DIR="$HOME/$FILE_DIR"
        echo "Create $DST_DIR"
        mkdir -p "$DST_DIR"
    fi

    echo "Link $DST_PATH << $SRC_PATH"
    ln -sf "$SRC_PATH" "$DST_PATH"
done

defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0

tmutil addexclusion ~/Applications
tmutil addexclusion ~/Downloads
