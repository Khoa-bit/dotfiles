#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# set -o errexit -o nounset

yayIns="yay -S --needed"
yayRns="yay -Rns --noconfirm --needed"

# ! Enable services
# ! auto-cpufreq - Automatic CPU speed & power optimizer for Linux
# Configure auto-cpufreq - https://github.com/AdnanHodzic/auto-cpufreq#auto-cpufreq-modes-and-options
echo -e "${GREEN}\n<> To enable auto-cpufreq create a service for it by:${NC}"
echo -e "systemctl enable auto-cpufreq.service"

installTLP() {
    # https://github.com/linrunner/TLP
    $yayRns auto-cpufreq power-profiles-daemon
    $yayIns tlp tlp-rdw
    sudo systemctl enable tlp.service
    sudo systemctl enable NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
}

installAutoCpuFreq() {
    # https://github.com/AdnanHodzic/auto-cpufreq
    $yayRns power-profiles-daemon tlp tlp-rdw
    $yayIns auto-cpufreq
    sudo systemctl enable auto-cpufreq.service
}

installPowerProfilesDaemon() {
    # Usually the default for most Distros
    # https://gitlab.freedesktop.org/hadess/power-profiles-daemon
    $yayRns auto-cpufreq tlp tlp-rdw
    $yayIns power-profiles-daemon
    sudo systemctl enable power-profiles-daemon
}

disableServices() {
    sudo systemctl disable tlp.service
    sudo systemctl disable NetworkManager-dispatcher.service
    sudo systemctl unmask  systemd-rfkill.service systemd-rfkill.socket
    sudo systemctl disable auto-cpufreq.service
    sudo systemctl disable power-profiles-daemon
}

# === Main ===
echo -e "${RED}\n!! Warning !! Please check the currently running optimize service${NC}"
systemctl list-units "tlp.service" "auto-cpufreq.service" "power-profiles-daemon.service"
echo -e "${RED}\n!! Warning !!${NC}"


sudo echo -e "${GREEN}\n<> Successfully authenticated as SU...${NC}"

echo -e "${YELLOW}\n<> Choose your current desktop environment:${NC}"
select choice in "tlp" "auto-cpufreq" "power-profiles-daemon"; do
    case $choice in
        "tlp" )
            disableServices
            installTLP
            break;;
        "auto-cpufreq" )
            disableServices
            installAutoCpuFreq
            break;;
        "power-profiles-daemon")
            disableServices
            installPowerProfilesDaemon
            break;;
    esac
done
echo -e "${GREEN}\n== Chosen: ${DESKTOP_ENV} ==${NC}"
