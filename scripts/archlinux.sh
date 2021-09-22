#!/usr/bin/env sh

set -o errexit -o nounset

# install yay
sudo pacman -S --noconfirm --needed yay base-devel wget


ins="yay -S --noconfirm --needed"
install() {
    # ttf-google-fonts-git, ttf-mac-fonts are not installed.
    # scrcpy for android app development :>
    # minecraft-server for :>

  $ins zsh ttf-ms-fonts ibus-bamboo \
    chromium calibre picard qbittorrent discord \
    ffmpeg youtube-dl exa vlc xdman \
    oh-my-zsh-git autojump-git fzf thefuck tldr \
    git rar gitkraken \
    gnome-keyring code vscodium-bin \
    intellij-idea-ultimate-edition pycharm-professional \
    easystroke touchegg touche
}

createSymlink() {
  ln -sf ~/.vscode ~/.vscode-os
  ln -sf ~/.config/Code/User ~/.config/VSCodium/User
}

extractKDEScript() {
  # Install kwin parachute
  # Open autostart and set easytouch, ksuperkey-parachute, sleep-and-restart-kwin
  cp ../KDE\ scripts/* ~/.local/bin/
}

install
createSymlink