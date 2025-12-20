# /home/akane/nixos-config/configuration.nix
{ config, lib, pkgs, ... }:
let
  # Импортируем файл с пакетами
  myPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [ 
    ./hardware-configuration.nix
    ./dotfiles.nix
  ];

  # Загрузка
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Сеть
  networking.hostName = "DesMia";
  networking.networkmanager.enable = true;

  # Время
  time.timeZone = "Asia/Yekaterinburg";

  # Настройки Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Графика
  services.xserver.videoDrivers = ["nvidia"];
  
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

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Сервисы
  services = {
    # Дисплей менеджер
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    
    # Звук (ИСПРАВЛЕНО - критически важно для Dota 2)
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;

      # ИСПРАВЛЕННАЯ конфигурация PipeWire
      # Старый вариант (extraConfig.pipewire) не работал
      extraConfig.pipewire = {
        "context.properties" = {
          "link.max-buffers" = 16;
          "log.level" = 2;
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 8192;
        };
      };
    };

    # Дополнительные сервисы
    udisks2.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Безопасность
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Пользователь
  users.users.akane = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    packages = myPackages.userPackages;
  };

  # Переменные окружения (ДОБАВЛЕНО для Dota 2)
  environment.sessionVariables = {
    # Wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # NVIDIA
    LIBVA_DRIVER_NAME = "nvidia";
    
    # КРИТИЧЕСКИ ВАЖНО для звука в Dota 2 с PipeWire
    # Принудительно указываем SDL2 использовать PipeWire
    SDL_AUDIODRIVER = "pipewire";
    # Альтернативный вариант, если pipewire не сработает:
    # SDL_AUDIODRIVER = "pulse";
  };

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ] ++ myPackages.systemPackages
    ++ myPackages.gamingPackages;

  system.stateVersion = "25.11"; # Не меняй это
}