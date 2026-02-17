#!/bin/bash
# Script to automatically update the Homebrew formula after a release
# Usage: ./update-homebrew-formula.sh [VERSION]
# If VERSION is not provided, it will be auto-detected from the latest GitHub release

set -e

# Configuration
REPO_OWNER="debba"
REPO_NAME="storytel-player"
FORMULA_FILE="Casks/storytel-player.rb"

# Get version from argument or environment variable
VERSION=${1:-$VERSION}

# If version is not provided, fetch the latest release from GitHub
if [ -z "$VERSION" ]; then
    echo "Auto-detecting latest version from GitHub releases..."
    
    # Use GitHub API to get the latest release
    LATEST_RELEASE=$(curl -sL \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest")
    
    # Extract version from tag_name (remove 'v' prefix if present)
    VERSION=$(echo "$LATEST_RELEASE" | grep -o '"tag_name": "[^"]*"' | cut -d'"' -f4)
    VERSION="${VERSION#v}"
    
    if [ -z "$VERSION" ]; then
        echo "Error: Could not detect latest version from GitHub API"
        echo "API Response: $LATEST_RELEASE"
        exit 1
    fi
    
    echo "Latest version detected: v${VERSION}"
fi

# Remove 'v' prefix if present
VERSION="${VERSION#v}"

echo "Updating Homebrew formula for Storytel Player v${VERSION}..."

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Set the formula file path
FORMULA_PATH="${PROJECT_ROOT}/${FORMULA_FILE}"

# Check if formula file exists
if [ ! -f "$FORMULA_PATH" ]; then
    echo "Error: Formula file not found at ${FORMULA_PATH}"
    exit 1
fi

# Get current version from formula
CURRENT_VERSION=$(grep -o 'version "[^"]*"' "$FORMULA_PATH" | head -1 | cut -d'"' -f2)
echo "Current formula version: ${CURRENT_VERSION}"

# Skip if already up to date
if [ "$VERSION" == "$CURRENT_VERSION" ]; then
    echo "Formula is already up to date (v${VERSION})"
    exit 0
fi

BASE_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}/releases/download/v${VERSION}"

echo "Downloading and calculating SHA256..."

# Create temp directory for downloads
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Download universal DMG
echo "Downloading Universal DMG..."
DMG_URL="${BASE_URL}/Storytel-Player-${VERSION}.dmg"
curl -sL --fail "$DMG_URL" -o "${TEMP_DIR}/storytel-player.dmg" || {
    echo "Error: Failed to download DMG from $DMG_URL"
    exit 1
}
# Use shasum for cross-platform compatibility (works on both macOS and Linux)
SHA256=$(shasum -a 256 "${TEMP_DIR}/storytel-player.dmg" | cut -d' ' -f1)
echo "Universal DMG SHA256: ${SHA256}"

# Update the formula using sed (macOS-compatible)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/version \"[^\"]*\"/version \"${VERSION}\"/" "$FORMULA_PATH"
    sed -i '' "s/sha256 \"[^\"]*\"/sha256 \"${SHA256}\"/" "$FORMULA_PATH"
else
    # Linux
    sed -i "s/version \"[^\"]*\"/version \"${VERSION}\"/" "$FORMULA_PATH"
    sed -i "s/sha256 \"[^\"]*\"/sha256 \"${SHA256}\"/" "$FORMULA_PATH"
fi

echo ""
echo "✓ Formula updated successfully!"
echo ""
echo "Changes made to ${FORMULA_FILE}:"
echo "  Version: ${CURRENT_VERSION} → ${VERSION}"
echo "  SHA256: ${SHA256}"
echo ""
echo "Verify locally with:"
echo "  brew install --cask ${FORMULA_PATH}"
echo ""
echo "Or test the formula syntax:"
echo "  brew audit --cask ${FORMULA_PATH}"
