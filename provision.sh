#!/bin/sh

set -e

CURRENT=$(pwd)
MISC_FOLDER="misc"

defaults write -g ApplePressAndHoldEnabled 0
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores 1
defaults write com.apple.TextEdit RichText 0
defaults write com.googlecode.iterm2 HotkeyTermAnimationDuration -float 0.001

tmutil addexclusion ~/Downloads

echo ">>> Link misc configs"
find ${MISC_FOLDER} -type f -print0 | while IFS= read -r -d '' line; do
    FILE_DIR=$(dirname "$line" | sed "s|^${MISC_FOLDER}/||")
    FILE_PATH=$(echo "$line" | sed "s|^${MISC_FOLDER}/||")
    SRC_PATH="$CURRENT/${MISC_FOLDER}/$FILE_PATH"
    DST_PATH="$HOME/$FILE_PATH"

    if [ ! -z "$FILE_DIR" ]; then
        DST_DIR="$HOME/$FILE_DIR"
        if [ ! -d "$DST_DIR" ]; then
            echo "Create $DST_DIR"
            mkdir -p "$DST_DIR"
        fi
    fi

    echo "Link: $DST_PATH << $SRC_PATH"
    ln -sf "$SRC_PATH" "$DST_PATH"
done

if [ -z "$FULL" ]; then
    echo "Done! Use INIT=1 to run full setup"
    exit 0
fi

if [ ! -x /usr/bin/gcc ]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

if [ ! -x /opt/homebrew/bin/brew ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
brew bundle

if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo ">>> Remove WireGuard from autoload"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -R -f -u /Applications/WireGuard.app

mkdir -p ~/d
