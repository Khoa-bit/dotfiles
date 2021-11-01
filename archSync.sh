#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}<> Syncing .zshrc, .p10k.zsh, .gitconfig...\n${NC}"
cp -v --force $HOME/.zshrc $HOME/.p10k.zsh $HOME/.gitconfig ./

echo -e "${BLUE}<> Syncing .fonts...\n${NC}"
cp -v --force -r $HOME/.fonts ./

echo -e "${BLUE}<> Syncing .oh-my-zsh/custom...\n${NC}"
cp -v --force -r $HOME/.oh-my-zsh/custom ./.oh-my-zsh/
rm -v -r ./.oh-my-zsh/custom/themes/powerlevel10k

echo -e "${BLUE}<> Syncing .local/bin/*.sh...\n${NC}"
cp -v --force $HOME/.local/bin/*.sh ./.local/bin

echo -e "${BLUE}<> Syncing 2 Packages...\n${NC}"
cp -v --force -r $HOME/Packages/ChromeOsButtons ./Packages
cp -v --force -r $HOME/Packages/HandMade_Notion_Icons ./Packages

echo -e "${GREEN}<> Done!\n${NC}"
