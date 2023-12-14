#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -o errexit -o nounset

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
echo -e "${BLUE}\n <> Creating backup directory...${NC}"
rm -rfv ./backup
mkdir -vp ./backup

echo -e "${BLUE}\n <> Backing up .zshrc, .p10k.zsh, .gitconfig...${NC}"
cp -vf $HOME/.zshrc $HOME/.p10k.zsh $HOME/.gitconfig $HOME/.condarc ./backup

echo -e "${BLUE}\n <> Backing up .local/bin/*.sh...${NC}"
mkdir -vp ./backup/.local/bin
cp -vf $HOME/.local/bin/*.sh ./backup/.local/bin

echo -e "${BLUE}\n <> Backing up .local/share/konsole...${NC}"
mkdir -vp ./backup/.local/share
cp -vrf $HOME/.local/share/konsole ./backup/.local/share

echo -e "${BLUE}\n <> Backing up .fonts...${NC}"
echo -e "${YELLOW}Skipped!${NC}"
# 7z a ./backup/fonts.7z -w $HOME/.fonts

echo -e "${BLUE}\n <> Replacing User tag for all files ...${NC}"
replaceUserTag $USER

echo -e "${GREEN}\n<> Done!\n${NC}"
