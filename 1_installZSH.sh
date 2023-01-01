#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

pacmanIns="sudo pacman -S --noconfirm --needed"

sudo echo -e "${GREEN}\n<> Successfully authenticated as SU...${NC}"

echo -e "${BLUE}\n<> Installing ZSH...${NC}"
$pacmanIns zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
