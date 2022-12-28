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
        flatpak latte-dock qdirstat syncthing \
        ffmpeg youtube-dl exa zoxide xdman \
        fzf thefuck tldr bat ripgrep \
        git 7-zip-full snapd openssl \
        podman fuse-overlayfs slirp4netns \
        gnome-keyring \
        auto-cpufreq neofetch cpufetch-git cmatrix pipes-rs-git \
        notion-app-enhanced stremio

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

flatpakIns="flatpak install --no-wait"
flatpakInstall() {
    echo -e "${BLUE}\n<> Installing Snap packages...${NC}"
    flatpak install -y \
        flathub com.getpostman.Postman com.visualstudio.code \
        com.discordapp.Discord com.brave.Browser org.videolan.VLC \
        com.github.tchx84.Flatseal com.obsproject.Studio \
        com.bitwarden.desktop org.qbittorrent.qBittorrent \
        com.vscodium.codium com.axosoft.GitKraken
        # com.calibre_ebook.calibre org.musicbrainz.Picard
}

scriptInstall() {
    echo -e "${BLUE}\n<> Installing scripts...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
    curl -fsSL https://get.pnpm.io/install.sh | sh - #pnpm
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
        bash Mambaforge-$(uname)-$(uname -m).sh -
    conda init
    curl -s "https://get.sdkman.io" | zsh # SDKMan!
    
    source ~/.zshrc
    pnpm add -g tldr
}

archConfig() {
    echo -e "${BLUE}\n<> Config Arch...${NC}"
    sh ./archCreateSymlink.sh
    sh ./archExtract.sh
    sh ./archCustomize.sh
}

podmanRootless() {
    echo -e "${BLUE}\n<> Config Podman Rootless...${NC}"
    sudo sysctl kernel.unprivileged_userns_clone=1 -w
    sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER
    podman system migrate
}

# === Main ===
pacmanInstall
yayUpdate
yayInstall $1
snapInstall
scriptInstall
echo -e "${GREEN}\n<> Installation Done!${NC}"

podmanRootless
archConfig
echo -e "${GREEN}\n<> Setup Done!${NC}"

# ! Enable services
# ! auto-cpufreq - Automatic CPU speed & power optimizer for Linux
# Configure auto-cpufreq - https://github.com/AdnanHodzic/auto-cpufreq#auto-cpufreq-modes-and-options
echo -e "${GREEN}\n<> To enable auto-cpufreq create a service for it by:${NC}"
echo -e "systemctl enable auto-cpufreq.service"
