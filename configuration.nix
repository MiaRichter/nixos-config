# /home/akane/nixos-config/configuration.nix
{ config, lib, pkgs, ... }:
{
  services.xserver.videoDrivers = ["nvidia"];
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
     ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "DesMia";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Yekaterinburg";

  nixpkgs.config.allowUnfree = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # withUWSM НЕ СУЩЕСТВУЕТ в stable-ветке Hyprland для NixOS 25.11
    # Это опция из unstable/nightly
    # withUWSM = true;
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ВСЕ сервисы должны быть в одном блоке
  services = {
    # Дисплей менеджер
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    
    # Звук
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };
  
  users.users.akane = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    packages = myPackages.userPackages;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    # Системные пакеты из отдельного файла
  ] ++ myPackages.systemPackages
    ++ myPackages.gamingPackages;  # Добавляем игровые пакеты

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  system.stateVersion = "25.11"; # Не меняй это
}
