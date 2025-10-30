#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "❌ Error: No Mesa version specified."
    echo "Usage: ./build-mesa.sh <version-name>"
    echo "Example: ./build-mesa.sh 24.1.0"
    exit 1
fi

MESA_VERSION="$1"
ARCHIVE_NAME="mesa-$MESA_VERSION.tar.xz"
SOURCE_DIR="mesa-$MESA_VERSION"
DOWNLOAD_URL="https://archive.mesa3d.org/$ARCHIVE_NAME"
BUILD_DIR="builddir"
PREFIX_PATH="$HOME/.mesa-custom/$MESA_VERSION"
if [ -d "$PREFIX_PATH" ]; then
    echo "ℹ️ Mesa version already exists: $MESA_VERSION"
    exit 0
fi

echo "🔎 Checking for source archive: $ARCHIVE_NAME"
if [ ! -f "$ARCHIVE_NAME" ]; then
    echo "🔃 Downloading Mesa $MESA_VERSION..."
    if command -v wget &> /dev/null; then
        wget -c "$DOWNLOAD_URL"
    elif command -v curl &> /dev/null; then
        curl -fSLO "$DOWNLOAD_URL"
    else
        echo "❌ Error: Neither wget nor curl is installed. Please install one."
        exit 1
    fi
else
    echo "ℹ️ Archive already exists. Skipping download."
fi

echo "📦 Unpacking source code..."
if [ -d "$SOURCE_DIR" ]; then
    echo "💥 Removing existing source directory: $SOURCE_DIR"
    rm -rf "$SOURCE_DIR"
fi
tar -xvf "$ARCHIVE_NAME"

cd "$SOURCE_DIR"

echo "🚀 Starting Mesa build for version: $MESA_VERSION"
echo "Installation directory will be: $PREFIX_PATH"

echo "⚒️ Configuring build..."

if command -v meson &> /dev/null; then
    meson setup "$BUILD_DIR" \
        --libdir lib64 \
        --prefix="$PREFIX_PATH" \
        -Dgallium-drivers=all \
        -Dvulkan-drivers=all \
        -Dgallium-rusticl=true \
        -Dllvm=enabled \
        -Dvideo-codecs=all \
        -Dbuildtype=release

    echo "🛠️ Compiling Mesa... (This may take a while)"
    meson compile -C "$BUILD_DIR"

    echo "📦 Installing Mesa..."
    meson install -C "$BUILD_DIR"

    echo "✅ Successfully downloaded, built, and installed Mesa $MESA_VERSION to $PREFIX_PATH"
    cd ..
    echo "💥 Removing existing source directory: $SOURCE_DIR"
    rm -rf "$SOURCE_DIR"
    echo "💥 Removing existing archive: $ARCHIVE_NAME"
    rm -rf "$ARCHIVE_NAME"
else 
    echo "❌ Error: meson is not installed."
    exit 1
fi
