#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -o errexit -o nounset

keepExistingConfig() {
    array=( "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.gitconfig" \
        "$HOME/.condarc" "$HOME/.local" "$HOME/Packages" )

    # iterate over each element in turn
    for item in "${array[@]}"; do
        if [ -e ${item} ]
            then cp -rf -v ${item} "${item}.old"
        fi
    done
}

referenceUserTag() {
    shopt -s globstar
    shopt -s dotglob
    shopt -s nocaseglob
    
    for file in backup/**/*.*; do 
        if [ -d "$file" ]; then continue; fi
        echo sed -i "s/\$USER/$USER/g" $file
        sed -i "s/\$USER/$USER/g" $file
    done
}

replaceUserTag() {
    shopt -s globstar
    shopt -s dotglob
    shopt -s nocaseglob
    
    for file in backup/**/*.*; do 
        if [ -d "$file" ]; then continue; fi
        echo sed -i "s/$USER/\$USER/g" $file
        sed -i "s/$USER/\$USER/g" $file
    done
}

# === Main ===
echo -e "${BLUE}\n<> Restoring backup...\n${NC}"

echo -e "${BLUE}\n <> Referencing User tag for all backup files ...${NC}"
referenceUserTag $USER

echo -e "${BLUE}\n<> Keeping up existing config with .old...${NC}"
keepExistingConfig

echo -e "${BLUE}\n<> Extracting .zshrc, .p10k.zsh, .gitconfig...${NC}"
cp -vf ./backup/.zshrc ./backup/.p10k.zsh ./backup/.gitconfig ./backup/.condarc $HOME

echo -e "${BLUE}\n<> Extracting .local/bin/*.sh...${NC}"
cp -vrf ./backup/.local/bin $HOME/.local

echo -e "${BLUE}\n<> Extracting .local/bin/share...${NC}"
cp -vrf ./backup/.local/share $HOME/.local

echo -e "${BLUE}\n<> Extracting Packages...${NC}"
cp -vrf ./backup/Packages $HOME

echo -e "${YELLOW}\n<> Extracting .fonts is disabled${NC}"
# 7z x ./backup/fonts.7z -o$HOME

echo -e "${BLUE}\n <> Replacing User tag for all files ...${NC}"
replaceUserTag $USER

echo -e "${GREEN}\n<> Done!${NC}"
