#!/usr/bin/env sh

set -o errexit -o nounset

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
        chromium calibre picard qbittorrent discord \
        ffmpeg youtube-dl exa vlc xdman \
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
    echo -e "${BLUE}\n<> Installing .fonts...${NC}"

    $snapIns "--classic" "gitkraken"
    $snapIns "--classic" "pycharm-professional"
    $snapIns "--classic" "webstorm"
    $snapIns "figma-linux"
}

createSymlink() {
    echo -e "${BLUE}\n<> Installing .fonts...${NC}"

    ln -sf $HOME/.vscode $HOME/.vscode-os
    ln -sf $HOME/.config/Code/User $HOME/.config/VSCodium/User
}

pacmanInstall
yayUpdate
yayInstall
snapInstall
createSymlink
sh ./archExtract.sh
sh ./archCustomize.sh

echo -e "${GREEN}\n======================= Manual Instructions =======================${BLUE}"
echo -e '1. Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.'
echo -e '2. Edit ~/.p10k.zsh to Customize powerlevel10k'
echo -e '3. Install and Apply Kwin Scripts:'
echo -e '   a. Activate Latte Launcher Menu'
echo -e '   b. Force Blur'
echo -e '   c. Latte Window Colors'
echo -e '   d. Parachute'
echo -e '   e. Sticky Window Snapping'
echo -e '4. Open autostart and Set:'
([ $# -eq 1 ] && [ $1 == 'X11' ]) && echo -e '   a. App:     Easystroke' || echo -e '   a. App:     ---'
echo -e '   b. Script:  .local/bin/ksuperkey-parachute.sh'
echo -e '   c. Script:  .local/bin/sleep-and-restart-kwin.sh'
echo -e '5. Not include any Look and Feel customizations'
echo -e '   a. Plasma style:        Future-dark'
echo -e '   b. Window Decorations:  No border + No titlebar button tooltips'
echo -e '   c. Fonts:               SF UI Display + SF Mono'
echo -e '   d. Icons:               Reversal-blue + HandMade_Notion_Icons'
echo -e '       - Follow Paths.txt instructions in ~/Packages/HandMade_Notion_Icons'
echo -e '   e. Cursors:             BreezeX-Black'
echo -e '   f. GitHub repos:        WhiteSur-kde, WhiteSur-icon-theme, McMojave-cursors, moe-theme'
echo -e '6. ZSH Plugins:'
echo -e '   a. zsh-syntax-highlighting'
echo -e '       $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
echo -e '   b. zsh-autosuggestions'
echo -e '       $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
echo -e '   c. Update .zshrc'
echo -e '       plugins=(git zsh-syntax-highlighting zsh-autosuggestions thefuck fzf)'
([ $# -eq 1 ] && [ $1 == 'X11' ]) && echo -e '7. Configure gestures Touche - Touchegg'

echo -e "${GREEN}\n========================== Not Installed ==========================${NC}"
echo -e "${YELLOW}<> ttf-google-fonts-git, ttf-mac-fonts    for additional fonts${NC}"
echo -e "${YELLOW}<> scrcpy                                 for Android app development${NC}"
echo -e "${YELLOW}<> CiscoPacketTracer                      for Computer Networking Sim${NC}"
echo -e "${YELLOW}<> kvantum-qt5                            for Look and Feel customization${NC}"
echo -e "${YELLOW}<> minecraft-server                       for joy :>${NC}"
echo -e "${YELLOW}<> applet-window-appmenu                  for window appmenu (GitHub Repo)${NC}"
echo -e "${YELLOW}<> applet-window-buttons                  for window buttons (GitHub Repo)${NC}"
echo -e "${YELLOW}<> latte-dock                             for Latte dock (GitHub Repo)${NC}"
echo -e "${YELLOW}<> Yin-Yang                               for Yin Yang (GitHub Repo)${NC}"

echo -e "${GREEN}\n===================================================================\n${NC}"
