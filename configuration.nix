{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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
    withUWSM = true;
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  # ПРАВИЛЬНЫЕ НАСТРОЙКИ ДЛЯ NixOS 25.11:
  # hardware.graphics был переименован обратно в hardware.opengl
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    driSupport32Bit = true;  # Для 32-битных приложений (Steam и др.)
    # Если используете NVIDIA:
    extraPackages = with pkgs; [
      # Для NVIDIA нужно добавить эти пакеты
      nvidia-vaapi-driver
    ];
  };

  # Звуковая система
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };

  users.users.akane = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    packages = with pkgs; [
      kitty
      firefox
      rofi
      nautilus
    ];
  };

  # Настройки сессии и Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    # Для NVIDIA:
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    vim
    nano
    hyprpaper
    hyprlock
    hypridle
    htop
    neofetch
    zip
    unzip
    wget
    git
    # Для NVIDIA:
    nvtopPackages.nvidia
  ];

  # XDG порталы
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland  # Для Hyprland
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Убедитесь, что эта версия соответствует вашей фактической версии NixOS
  system.stateVersion = "25.11"; # Или "24.11" если не обновлялись до 25.11
}