#!/bin/bash

set -e

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

if [[ ! -f /Applications/Rosetta.app ]]; then
    echo "Installing Rosetta..."
    softwareupdate --install-rosetta
fi

if [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew doctor
brew bundle

cd assets && find . -type f -print0 |
while IFS= read -r -d '' line; do
    # mkdir -p "~/$line"
    # ln -s
    # echo $(dirname $line)
    ROOT_DIR=`dirname "$line" | cut -c 3-`
    FILE_PATH=`echo "$line" | cut -c 3-`
    DST_PATH="~/$FILE_PATH"
    SRC_PATH="$(pwd)/$FILE_PATH"

    if [ ! -z "$ROOT_DIR" ]; then
        mkdir -p "$ROOT_DIR"
    fi

    echo "$DST_PATH << $SRC_PATH"
    ln -sf "$SRC_PATH" "$DST_PATH"
done

defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0

tmutil addexclusion ~/Applications
tmutil addexclusion ~/Downloads
tmutil addexclusion ~/Library/Caches/com.docker.docker
