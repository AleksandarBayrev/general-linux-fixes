#!/bin/bash

echo "🗑️  Starting Gamescope uninstallation..."

# Define paths
INSTALL_DIR="$HOME/.local/share/gamescope"
BIN_DIR="$HOME/.local/bin"

# 1. Remove the symbolic links
if [ -L "$BIN_DIR/gamescope" ]; then
    echo "🔗 Removing symbolic link: $BIN_DIR/gamescope"
    rm "$BIN_DIR/gamescope"
fi

if [ -L "$BIN_DIR/gamescopereaper" ]; then
    echo "🔗 Removing symbolic link: $BIN_DIR/gamescopereaper"
    rm "$BIN_DIR/gamescopereaper"
else
    echo "⏩ Symlink not found, skipping..."
fi

# 2. Remove the shared files
if [ -d "$INSTALL_DIR" ]; then
    echo "📁 Removing installation directory: $INSTALL_DIR"
    rm -rf "$INSTALL_DIR"
else
    echo "⏩ Installation directory not found, skipping..."
fi

echo "---"
echo "✨ Gamescope has been removed."
echo "Note: This did not remove any system dependencies or your PATH configuration."