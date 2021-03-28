#!/usr/bin/env sh

set -o errexit -o nounset

apt_ins="apt install -y"
ppa_ins="add-apt-repository"
snap_ins="snap install -y"

apt_install() {
    # ttf-google-fonts-git, ttf-mac-fonts are not installed.
    # scrcpy for android app development :>
    # minecraft-server for :>

  sudo $apt_ins zsh fzf autojump \
    net-tools dconf-editor gnome-tweaks chrome-gnome-shell
    calibre qbittorrent discord \
    ffmpeg youtube-dl vlc \
    git unrar gitkraken \
    code codium
  
  sudo apt install python3-dev python3-pip python3-setuptools
  sudo pip3 install thefuck
}

ppa_install() {
  sudo $ppa_ins ppa:musicbrainz-developers/stable
  sudo $ppa_ins ppa:agornostal/ulauncher
  sudo $ppa_ins ppa:bamboo-engine/ibus-bamboo

  sudo $apt_ins picard ulauncher ibus-bamboo

  ibus restart
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
}

pkgs = "chromium"
classic_pkgs = "intellij-idea-ultimate pycharm-professional"
snap_install() {
  sudo $snap_ins $pkgs
  sudo $snap_ins --classic $classic_pkgs

  cp /var/lib/snapd/desktop/applications/* ~/.local/share/applications/

}

install_ms_font() {
    sudo apt update && sudo apt install ttf-mscorefonts-installer
}

apt_install

snap_install

install_ms_font

echo "=========================================="
echo "Copied snap apps into local's applications folder for applying icon pack"
echo "Cuz I don't know how to edit files automaticly, Please edit ICON tag of .desktop files :>"
echo "=========================================="
echo "XDMan apps must be manually install, unfortunately. :<"
echo "https://github.com/subhra74/xdm/releases"
echo "=========================================="