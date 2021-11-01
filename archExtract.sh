#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}\n<> Extracting .zshrc, .p10k.zsh, .gitconfig...${NC}"
cp -v --interactive ./.zshrc ./.p10k.zsh ./.gitconfig $HOME

echo -e "${BLUE}\n<> Extracting .fonts...${NC}"
cp -v --interactive -r ./.fonts $HOME

echo -e "${BLUE}\n<> Extracting .oh-my-zsh/custom...${NC}"
cp -v --interactive -r ./.oh-my-zsh $HOME

echo -e "${BLUE}\n<> Extracting .local/bin/*.sh...${NC}"
cp -v --interactive -r ./.local $HOME

echo -e "${BLUE}\n<> Extracting Packages...${NC}"
cp -v --interactive -r ./Packages $HOME

echo -e "${GREEN}\n<> Done!${NC}"
