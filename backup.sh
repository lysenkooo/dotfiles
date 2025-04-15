#!/bin/bash

set -euo pipefail

BACKUP_DIR="$HOME/dotfiles/settings"
PLISTS_DIR="$BACKUP_DIR/plists"
SYS_CONFIG_DIR="$BACKUP_DIR/systemconfig"
LOG_FILE="/tmp/backup.log"

mkdir -p "$PLISTS_DIR" "$SYS_CONFIG_DIR"

log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🔧 Starting macOS user settings backup..."

# List of known user preference domains to export
DOMAINS=(
  com.apple.dock
  com.apple.finder
  com.apple.systempreferences
  com.apple.screencapture
  com.apple.screensaver
  com.apple.universalaccess
  com.apple.print.PrintingPrefs
  com.apple.spaces
  NSGlobalDomain
)

log "📦 Exporting user preference domains..."

for domain in "${DOMAINS[@]}"; do
  safe_name="${domain//./_}"
  OUTPUT="$PLISTS_DIR/${safe_name}.plist"
  if defaults export "$domain" - > "$OUTPUT" 2>/dev/null; then
    log "✅ Exported: $domain"
  else
    log "⚠️ Skipped (not found or error): $domain"
    rm -f "$OUTPUT"
  fi
done

# Export raw .plist files from ~/Library/Preferences (carefully!)
PLIST_FILES=(
  com.apple.HIToolbox.plist
  com.apple.trackpad.plist
  com.apple.keyboard.plist
  com.apple.inputmethod.plist
  com.apple.Accessibility.plist
)

log "📄 Copying additional raw plist files..."

for plist in "${PLIST_FILES[@]}"; do
  SRC="$HOME/Library/Preferences/$plist"
  DEST="$PLISTS_DIR/$plist"
  if [ -f "$SRC" ]; then
    cp "$SRC" "$DEST"
    log "✅ Copied: $plist"
  else
    log "⚠️ Missing: $plist"
  fi
done

# Export selected network/system config (read-only)
SYSTEM_CONFIG_FILES=(
  preferences.plist
  NetworkInterfaces.plist
  com.apple.airport.preferences.plist
)

log "🌐 Exporting system network configuration files..."

for config in "${SYSTEM_CONFIG_FILES[@]}"; do
  SRC="/Library/Preferences/SystemConfiguration/$config"
  DEST="$SYS_CONFIG_DIR/$config"
  if [ -f "$SRC" ]; then
    cp "$SRC" "$DEST"
    log "✅ Copied system config: $config"
  else
    log "⚠️ Missing: $config"
  fi
done

log "🎉 Backup complete. Files saved to: $BACKUP_DIR"
