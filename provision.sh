#!/bin/bash

set -e

defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0
defaults write com.googlecode.iterm2 HotkeyTermAnimationDuration -float 0.001

mkdir -p ~/Projects
tmutil addexclusion ~/Downloads

CURRENT=`pwd`

if [[ ! -x /usr/bin/gcc ]]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

if [[ ! -x /opt/homebrew/bin/brew ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
brew bundle

# Remove WireGuard from autoload
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -R -f -u /Applications/WireGuard.app

if [[ ! -f ~/.nvm/nvm.sh ]]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
fi

if [[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

find configs -type f -print0 | while IFS= read -r -d '' line; do
    FILE_DIR=`dirname "$line" | cut -c 9-`
    FILE_PATH=`echo "$line" | cut -c 9-`
    SRC_PATH="$CURRENT/configs/$FILE_PATH"
    DST_PATH="$HOME/$FILE_PATH"

    if [ ! -z "$FILE_DIR" ]; then
        DST_DIR="$HOME/$FILE_DIR"
        echo "Create $DST_DIR"
        mkdir -p "$DST_DIR"
    fi

    echo "Link $DST_PATH << $SRC_PATH"
    ln -sf "$SRC_PATH" "$DST_PATH"
done
