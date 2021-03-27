#!/usr/bin/env sh

set -o errexit -o nounset

# install yay
sudo pacman -S --noconfirm --needed yay base-devel wget


ins="yay -S --noconfirm --needed"
install() {
    # ttf-google-fonts-git, ttf-mac-fonts are not installed.
    # scrcpy for android app development :>
    # minecraft-server for :>

  sudo $ins zsh ttf-ms-fonts nerd-fonts-complete ibus-bamboo \
    chromium calibre picard qbittorrent discord \
    ffmpeg youtube-dl vlc xdman \
    git rar gitkraken \
    code vscodium-bin \
    intellij-idea-ultimate-edition pycharm-professional
}

install