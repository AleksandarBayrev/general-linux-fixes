#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting Gamescope build and install process..."

# 1. Update submodules
echo "📦 Updating submodules..."
git submodule update --init

# 2. Setup build directory with Meson
echo "🏗️  Setting up build directory..."
meson setup build/

# 3. Compile the project
echo "🛠️  Compiling with Meson..."
meson compile -C build/

# 4. Prepare installation directories
echo "📁 Preparing local directories..."
INSTALL_DIR="$HOME/.local/share/gamescope"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

# 5. Copy build contents
echo "🚚 Copying build files to $INSTALL_DIR..."
cp -r build/src/* "$INSTALL_DIR/"

# 6. Create symbolic link
echo "🔗 Creating symbolic link in $BIN_DIR..."
# -f ensures it overwrites if the link already exists
ln -sf "$INSTALL_DIR/gamescope" "$BIN_DIR/gamescope"
ln -sf "$INSTALL_DIR/gamescopereaper" "$BIN_DIR/gamescopereaper"

GS_RUNNER_FILE="gamescope-runner"

# Check if the source file exists in the current directory
if [ ! -f "$GS_RUNNER_FILE" ]; then
    echo "❌ Error: Source file '$GS_RUNNER_FILE' not found in $(pwd)!" >&2
    exit 1
fi

cp $GS_RUNNER_FILE "$BIN_DIR/$GS_RUNNER_FILE"

echo "---"
echo "✅ Installation complete!"
echo ""
echo "💡 IMPORTANT: Ensure your PATH includes ~/.local/bin."
echo "Add the following line to your .bashrc or .zshrc if you haven't already:"
echo "export PATH=\"\$HOME/.local/bin:\$PATH\""