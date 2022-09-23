#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

echo -e "${BLUE}\n<> Creating symlink for VSCode + VSCodium...${NC}"

mkdir -vp $HOME/.config/VSCodium/User
ln -vsf $HOME/.vscode $HOME/.vscode-os
ln -vsf $HOME/.config/Code/User/snippets $HOME/.config/VSCodium/User/snippets
ln -vsf $HOME/.config/Code/User/keybindings.json $HOME/.config/VSCodium/User/keybindings.json
ln -vsf $HOME/.config/Code/User/settings.json $HOME/.config/VSCodium/User/settings.json
