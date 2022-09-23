#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -o errexit -o nounset

if [ $# -ne 1 ];
then
    echo -e "${RED}Missing 1 arugment${NC}"
    echo -e "sh $0 ${BLUE}<X11 or Wayland>${NC}"
    exit 0

elif [ $1 != "X11" ] && [ $1 != "Wayland" ];
then
    echo "${RED}Incorrect arugment: $1${NC}"
    echo -e "sh $0 ${BLUE}<X11 or Wayland>${NC}"
    exit 0

fi

# install yay and devel
pacmanIns="sudo pacman -S --noconfirm --needed base-devel wget yay"
pacmanInstall() {
    echo -e "${BLUE}\n<> Pacman Installing base-devel wget yay...${NC}"

    $pacmanIns
}

yayUp="yay -Syu --noconfirm --needed"
yayUpdate() {
    echo -e "${BLUE}\n<> Yay Updating system...${NC}"

    $yayUp
}

yayIns="yay -S --noconfirm --needed"
yayInstall() {
    echo -e "${BLUE}\n<> Yay Installing all packages...${NC}"

    $yayIns zsh ttf-ms-fonts ibus-bamboo \
        chromium calibre picard qbittorrent flatpak \
        ffmpeg youtube-dl exa zoxide vlc xdman \
        oh-my-zsh-git fzf thefuck tldr bat ripgrep \
        git rar snapd \
        gnome-keyring visual-studio-code-bin vscodium-bin \
        auto-cpufreq neofetch cpufetch-git cmatrix \
        notion-app-enhanced stremio

    # ! Enable services
    # ! auto-cpufreq - Automatic CPU speed & power optimizer for Linux
    # Configure auto-cpufreq - https://github.com/AdnanHodzic/auto-cpufreq#auto-cpufreq-modes-and-options
    systemctl enable auto-cpufreq.service

    if [ $1 == "X11" ];
    then
        echo -e "${BLUE}<> X11 packages Installing...${NC}"
        $yayIns easystroke touchegg touche

    elif [ $1 == "Wayland" ];
    then
        echo -e "${BLUE}<> Wayland packages Installing...${NC}"
    fi
}

snapIns="sudo snap install --no-wait"
snapInstall() {
    echo -e "${BLUE}\n<> Installing Snap packages...${NC}"
}

# === Main ===
pacmanInstall
yayUpdate
yayInstall
snapInstall
echo "${GREEN}\n<> Installation Done!${NC}"

sh ./archCreateSymlink.sh
sh ./archExtract.sh
sh ./archCustomize.sh
echo "${GREEN}\n<> Setup Done!${NC}"
