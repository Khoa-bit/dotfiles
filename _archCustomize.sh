#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

echo -e "${BLUE}\n<> Customizing Oh-my-zsh...${NC}"

echo -e "${BLUE}\n<> Installing powerlevel10k...${NC}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "${BLUE}\n<> Installing plugin zsh-autosuggestions...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "${BLUE}\n<> Installing plugin zsh-syntax-highlighting...${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
