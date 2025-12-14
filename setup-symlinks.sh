#!/bin/bash
# Создаем симлинки для конфигов

mkdir -p ~/.config/hypr
ln -sf ~/nixos-config/dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

echo "Симлинки созданы!"
