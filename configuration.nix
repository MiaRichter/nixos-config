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
    # Рекомендуется для NixOS 24.11+ [citation:3]
    withUWSM = true;
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  # ВНИМАНИЕ: Названия опций изменились в NixOS 25.11
  hardware.graphics = {
    enable = true;          # Было: hardware.opengl.enable
    enable32Bit = true;     # Было: hardware.opengl.driSupport32Bit
    # Для поддержки 32-битных приложений (например, Steam) можно добавить:
    # package = pkgs.mesa;
    # package32 = pkgs.pkgsi686Linux.mesa;
  };

  # Звуковая система - старая опция была переименована
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  users.users.akane = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; # Добавлен networkmanager
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
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
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
  ];

  # XDG порталы - убедитесь, что wlr.enable установлен
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr.enable = true;  # Используется для Hyprland
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # ВНИМАНИЕ: Используйте ту версию, на которую вы фактически обновились
  system.stateVersion = "25.11"; # Или "24.11", если вы ещё на ней
}