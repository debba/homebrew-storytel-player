[![Discord](https://img.shields.io/discord/1470772941296894128?color=5865F2&logo=discord&logoColor=white)](https://discord.gg/YrZPHAwMSG)

# Homebrew Storytel Player

Official Homebrew tap for [Storytel Player](https://github.com/debba/storytel-player) - An unofficial Storytel Player for Desktop.

**Discord** - [Join our discord server](https://discord.gg/YrZPHAwMSG) and chat with the maintainers.

## Installation

```bash
# Add this tap
brew tap debba/storytel-player

# Install Storytel Player
brew install --cask storytel-player
```

## Updates

The Homebrew formula is **automatically updated daily** via GitHub Actions. The workflow:

- Checks for new releases from `debba/storytel-player`
- Downloads the latest DMG file
- Calculates SHA256 checksum
- Updates the formula automatically
- Commits and pushes changes

You can also trigger the update manually from the GitHub Actions tab.

## Repository Structure

```
.
├── Casks/
│   └── storytel-player.rb          # Homebrew Cask formula
├── scripts/
│   └── update-homebrew-formula.sh  # Update script (used by CI)
├── .github/
│   └── workflows/
│       └── update-formula.yml    # Daily automated update workflow
├── README.md
└── LICENSE
```

## Manual Update

If you need to manually update the formula:

```bash
# Auto-detect latest version
./scripts/update-homebrew-formula.sh

# Or specify a version
./scripts/update-homebrew-formula.sh 1.2.7
```

## Requirements

- macOS 12 (Monterey) or later
- Homebrew installed

## About Storytel Player

Storytel Player is an unofficial cross-platform desktop application for playing Storytel audiobooks, built with TypeScript, React, Fastify, and Electron. It provides a native desktop experience with system tray integration, audiobook library management, and offline listening capabilities.

Visit the main repository: [github.com/debba/storytel-player](https://github.com/debba/storytel-player)

## License

This repository is licensed under [CC0 1.0 Universal](LICENSE) - you can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.

---

<p align="center">Made with ❤️ by <a href="https://github.com/debba">debba</a></p>