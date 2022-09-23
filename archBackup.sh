#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

echo -e "${BLUE}\n <> Creating backup directory...${NC}"
rm -rfv ./backup
mkdir -vp ./backup

echo -e "${BLUE}\n <> Backing up .zshrc, .p10k.zsh, .gitconfig...${NC}"
cp -vf $HOME/.zshrc $HOME/.p10k.zsh $HOME/.gitconfig ./backup

echo -e "${BLUE}\n <> Backing up .fonts...${NC}"
7z a ./backup/fonts.7z -w $HOME/.fonts

echo -e "${BLUE}\n <> Backing up .oh-my-zsh/custom...${NC}"
mkdir -vp ./backup/.oh-my-zsh
cp -vrf $HOME/.oh-my-zsh/custom ./backup/.oh-my-zsh
# Reinstall powerlevel10k from Github
rm -vr ./backup/.oh-my-zsh/custom/themes

echo -e "${BLUE}\n <> Backing up .local/bin/*.sh...${NC}"
mkdir -vp ./backup/.local
cp -vf $HOME/.local/bin/*.sh ./backup/.local

echo -e "${BLUE}\n <> Backing up 2 Packages...${NC}"
mkdir -vp ./backup/Packages/
cp -vrf $HOME/Packages/ChromeOsButtons ./backup/Packages
cp -vrf $HOME/Packages/HandMade_Notion_Icons ./backup/Packages

echo -e "${GREEN}\n<> Done!\n${NC}"
