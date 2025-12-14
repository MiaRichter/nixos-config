# 🚀 NixOS Configuration for DesMia

<div align="center">

![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-333333?style=for-the-badge&logoColor=white)
![Flakes](https://img.shields.io/badge/Flakes-Enabled-brightgreen?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Stable-green?style=for-the-badge)

*A modern NixOS configuration with Hyprland Wayland compositor*

</div>

## 📋 System Specifications

- **Hostname**: DesMia
- **Time Zone**: Asia/Yekaterinburg (GMT+5)
- **Display Manager**: GDM with Wayland
- **Window Manager**: Hyprland
- **Desktop Environment**: Hyprland (tiling WM)
- **Shell**: Bash/Zsh

### 🖥️ Hardware
- **GPU**: NVIDIA (with proper drivers)
- **Monitors**:
  - DP-2: Acer XF253Q (1920x1080 @ 240Hz)
  - DP-3: KTC AQW34H3 (3440x1440 @ 165Hz)

## 🛠️ Quick Start

### Update System (Safe Method)
```bash
cd /etc/nixos/nixos-config/
sudo nixos-rebuild switch --flake .#DesMia