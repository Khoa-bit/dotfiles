#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -o errexit -o nounset

# install yay and devel
pacmanIns="sudo pacman -S --noconfirm --needed"
pacmanInstall() {
    echo -e "${BLUE}\n<> Pacman Installing base-devel wget yay...${NC}"
    pacman -V

    $pacmanIns base-devel wget yay
}

yayUp="yay -Syu --noconfirm --needed"
yayUpdate() {
    echo -e "${BLUE}\n<> Yay Updating system...${NC}"

    $yayUp
}

yayIns="yay -S --noconfirm --needed"
yayInstall() {
    echo -e "${BLUE}\n<> Yay Installing all packages...${NC}"
    yay -V

    $yayIns nerd-fonts-complete ttf-ms-fonts ibus-bamboo \
        flatpak latte-dock qdirstat syncthing \
        ffmpeg ffprobe exa zoxide noto-fonts-emoji \
        fzf thefuck bat ripgrep github-cli \
        git 7-zip-full zip unzip snapd openssl yt-dlp \
        podman fuse-overlayfs slirp4netns \
        gnome-keyring vscodium-bin visual-studio-code-bin \
        fastfetch onefetch cpufetch-git clyrics nitch \
        cmatrix pipes-rs-git \
        notion-app-enhanced stremio plasma-systemmonitor \
        ttf-meslo-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd \
        ttf-roboto-mono-nerd ttf-ubuntu-nerd ttf-ubuntu-mono-nerd

    case $DESKTOP_ENV in
        "X11" ) 
            echo -e "${BLUE}<> Installing X11 packages...${NC}"
            # $yayIns easystroke touchegg touche
            break;;
        "Wayland" ) 
            echo -e "${BLUE}<> Installing Wayland packages...${NC}"
            break;;
    esac
}

snapIns="sudo snap install --no-wait"
snapInstall() {
    echo -e "${BLUE}\n<> Installing Snap packages...${NC}"
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
    snap --version
}

flatpakIns="flatpak install --no-wait"
flatpakInstall() {
    echo -e "${BLUE}\n<> Installing Flatpak packages...${NC}"
    flatpak --version

    flatpak install -y \
        flathub com.getpostman.Postman \
        com.discordapp.Discord com.brave.Browser org.videolan.VLC \
        com.github.tchx84.Flatseal com.obsproject.Studio \
        org.qbittorrent.qBittorrent \
        com.axosoft.GitKraken com.usebottles.bottles \
        org.libreoffice.LibreOffice org.nickvision.money
        # com.calibre_ebook.calibre org.musicbrainz.Picard
}

scriptInstall() {
    echo -e "${BLUE}\n<> Installing scripts...${NC}"
    npm install -g pnpm
    curl -s "https://get.sdkman.io" | zsh # SDKMan!    
}

archConfig() {
    echo -e "${BLUE}\n<> Configuring Arch...${NC}"
    sh ./_archCreateSymlink.sh
    sh ./_archExtract.sh
    sh ./_archCustomize.sh
}

podmanRootless() {
    echo -e "${BLUE}\n<> Configuring Podman Rootless...${NC}"
    sudo sysctl kernel.unprivileged_userns_clone=1 -w
    sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER
    podman system migrate
}

# === Main ===
sudo echo -e "${GREEN}\n<> Successfully authenticated as SU...${NC}"

DESKTOP_ENV=""

echo -e "${YELLOW}\n<> Choose your current desktop environment:${NC}"
select choice in "X11" "Wayland"; do
    DESKTOP_ENV=$choice
    break
done
echo -e "${GREEN}\n== Chosen: ${DESKTOP_ENV} ==${NC}"

pacmanInstall
yayUpdate
yayInstall $DESKTOP_ENV
snapInstall
scriptInstall
echo -e "${GREEN}\n<> Installation Done!${NC}"

archConfig
podmanRootless
echo -e "${GREEN}\n<> Setup Done!${NC}"
