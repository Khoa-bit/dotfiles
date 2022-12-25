#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

keepExistingConfig() {
    array=( "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.gitconfig" \
        "$HOME/.condarc" "$HOME/.oh-my-zsh" "$HOME/.local" "$HOME/Packages" )

    # iterate over each element in turn
    for item in "${array[@]}"; do
        if [ -e ${item} ]
            then mv -f -v ${item} "${item}.old"
        fi
    done
}

# === Main ===
echo -e "${BLUE}\n<> Extracting .zshrc, .p10k.zsh, .gitconfig...${NC}"
keepExistingConfig
cp -v ./backup/.zshrc ./backup/.p10k.zsh ./backup/.gitconfig ./backup/.condarc $HOME

echo -e "${BLUE}\n<> Extracting .fonts...${NC}"
7z x ./backup/fonts.7z -o$HOME

echo -e "${BLUE}\n<> Extracting .oh-my-zsh/custom...${NC}"
cp -v -r ./backup/.oh-my-zsh $HOME

echo -e "${BLUE}\n<> Extracting .local/bin/*.sh...${NC}"
cp -v -r ./backup/.local $HOME

echo -e "${BLUE}\n<> Extracting Packages...${NC}"
cp -v -r ./backup/Packages $HOME

echo -e "${GREEN}\n<> Done!${NC}"
