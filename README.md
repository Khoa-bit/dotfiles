# dotfiles

Personal Linux dotfiles.

## KDE Arch Linux

### Setup

```bash
# Setup for Arch X11
$ sh ./archSetup X11

# Setup for Arch Wayland
$ sh ./archSetup Wayland
```

### Backup and Sync

```bash
# Setup for Arch
$ sh ./archBackup
```

---

## KDE Arch Linux

### Manual Instructions

1.  Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc. (Double Check)
2.  Edit ~/.p10k.zsh to Customize powerlevel10k or "p10k configure" cmd (Double Check)
3.  Install and Apply Kwin Scripts:

    a. Activate Latte Launcher Menu

    b. Force Blur (Unnecessary)

    c. Latte Window Colors (Unnecessary)

    d. Sticky Window Snapping

4.  Open autostart and Set:

    a. App: Easystroke (If on KDE X11)

5.  Not include any Look and Feel customizations

    a. Plasma style: Future-dark

    b. Window Decorations: No border (Window border size) + No titlebar button tooltips (checkbox)

    c. Fonts: SF UI Display + SF Mono

    d. Icons: Reversal-blue + HandMade_Notion_Icons

        Follow Paths.txt instructions in ~/Packages/HandMade_Notion_Icons

    e. Cursors: BreezeX-Black

    f. GitHub repos: WhiteSur-kde, WhiteSur-icon-theme, McMojave-cursors, moe-theme

6.  Configure gestures Touche - Touchegg

### Not Installed

1. ttf-google-fonts-git, ttf-mac-fonts for additional fonts
2. scrcpy for Android app development
3. CiscoPacketTracer for Computer Networking Sim
4. kvantum-qt5 for Look and Feel customization
5. minecraft-server for joy :>
6. applet-window-appmenu for window appmenu (GitHub Repo)
7. applet-window-buttons for window buttons (GitHub Repo)
8. Yin-Yang for Yin Yang (GitHub Repo)
