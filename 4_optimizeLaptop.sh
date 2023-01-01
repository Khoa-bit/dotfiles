#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

set -o errexit -o nounset

yayIns="yay -S --noconfirm --needed"
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
    systemctl enable tlp.service
    systemctl enable NetworkManager-dispatcher.service
    systemctl mask systemd-rfkill.service systemd-rfkill.socket
}

installAutoCpuFreq() {
    # https://github.com/AdnanHodzic/auto-cpufreq
    $yayRns power-profiles-daemon tlp tlp-rdw
    $yayIns auto-cpufreq
    systemctl enable auto-cpufreq.service
}

installPowerProfilesDaemon() {
    # Usually the default for most Distros
    # https://gitlab.freedesktop.org/hadess/power-profiles-daemon
    $yayRns auto-cpufreq tlp tlp-rdw
    $yayIns power-profiles-daemon
    systemctl enable power-profiles-daemon
}

disableServices() {
    systemctl disable tlp.service
    systemctl disable NetworkManager-dispatcher.service
    systemctl unmask  systemd-rfkill.service systemd-rfkill.socket
    systemctl disable auto-cpufreq.service
    systemctl disable power-profiles-daemon
}

# === Main ===
echo -e "${RED}\n!! Warning !! Please check the currently running optimize service${NC}"
systemctl list-units "tlp.service" "auto-cpufreq.service" "power-profiles-daemon"
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
