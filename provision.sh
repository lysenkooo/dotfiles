#!/bin/sh

set -e

CURRENT=$(pwd)
ASSETS_FOLDER="assets"
MISC_FOLDER="misc"

echo ">>> Configure macOS"
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.TextEdit RichText -bool false
# defaults write com.googlecode.iterm2 HotkeyTermAnimationDuration -float 0.001

echo ">>> Exclude Downloads from Time Machine"
tmutil addexclusion ~/Downloads

echo ">>> Link private configs from iCloud"
ln -sf /Users/ccbe/Library/Mobile\ Documents/com\~apple\~CloudDocs/.my/zshrc_custom ~/.zshrc_custom

echo ">>> Link public configs from GitHub"
find ${ASSETS_FOLDER} -type f -print0 | while IFS= read -r -d '' line; do
    FILE_PATH=$(echo "$line" | sed "s|^${ASSETS_FOLDER}/||")
    FILE_DIR=$(dirname "$FILE_PATH")
    SRC_PATH="$CURRENT/${ASSETS_FOLDER}/$FILE_PATH"
    DST_PATH="$HOME/$FILE_PATH"

    if [ ! -z "$FILE_DIR" ]; then
        DST_DIR="$HOME/$FILE_DIR"
        if [ ! -d "$DST_DIR" ]; then
            echo "Create: $DST_DIR"
            mkdir -p "$DST_DIR"
        fi
    fi

    echo "Link: $DST_PATH << $SRC_PATH"
    ln -sf "$SRC_PATH" "$DST_PATH"
done

echo ">>> Setup root daemons"
sudo cp ${MISC_FOLDER}/Library/LaunchDaemons/com.ccbe.KeyRemapping.plist /Library/LaunchDaemons/
sudo chmod 0644 /Library/LaunchDaemons/com.ccbe.KeyRemapping.plist
sudo cp ${MISC_FOLDER}/Library/LaunchDaemons/com.ccbe.TTL.plist /Library/LaunchDaemons/
sudo chmod 0644 /Library/LaunchDaemons/com.ccbe.TTL.plist

if [ ! -x /usr/bin/gcc ]; then
    echo "Installing Command Line Tools..."
    xcode-select --install
fi

if [ ! -x /opt/homebrew/bin/brew ]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo ">>> Remove WireGuard from autoload"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -R -f -u /Applications/WireGuard.app > /dev/null 2>&1 || true

echo ">>> Create git ~/.mackup/data folder"
mkdir -p ~/.mackup/data

echo ">>> Create .gitignore in mackup folder"
cat <<EOF | tee ~/.mackup/.gitignore
data/.ansible/collections/
data/.vim/bundle/
data/.nvim/backups/
EOF

echo ">>> Create git repo"
cd ~/.mackup
git init || true

echo ">>> Create developemnt folder"
mkdir -p ~/Dev
