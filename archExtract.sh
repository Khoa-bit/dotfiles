#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

echo -e "${BLUE}\n<> Extracting .zshrc, .p10k.zsh, .gitconfig...${NC}"
cp -v $HOME/.zshrc $HOME/.zshrc.old
cp -v $HOME/.p10k.zsh $HOME/.p10k.zsh.old
cp -v $HOME/.gitconfig $HOME/.gitconfig.old
cp -v $HOME/.condarc $HOME/.condarc.old
cp -v ./backup/.zshrc ./backup/.p10k.zsh ./backup/.gitconfig ./backup/.condarc $HOME

echo -e "${BLUE}\n<> Extracting .fonts...${NC}"
7z x ./backup/fonts.7z -o$HOME

echo -e "${BLUE}\n<> Extracting .oh-my-zsh/custom...${NC}"
cp -v --interactive -r ./backup/.oh-my-zsh $HOME

echo -e "${BLUE}\n<> Extracting .local/bin/*.sh...${NC}"
cp -v --interactive -r ./backup/.local $HOME

echo -e "${BLUE}\n<> Extracting Packages...${NC}"
cp -v --interactive -r ./backup/Packages $HOME

echo -e "${GREEN}\n<> Done!${NC}"
