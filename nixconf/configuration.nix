# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./games.nix
      ./nvidia.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.fdf
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "alice";
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  time.timeZone = "Asia/Yekaterinburg";
  
  programs.fish.enable = true;
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

      # Удален config.pipewire - используем extraConfig
      # Экспериментальные настройки для Dota 2
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
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  users.users.anrew = {
     shell = pkgs.fish;
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" "video" "audio" "disk"]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  environment = {
    # Переменные для Wayland
    sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    };
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  services.udisks2.settings = {
    "udisks2.conf" = {
      "mount_options.conf" = {
        defaults = "uid=$UID,gid=$GID";
        ntfs_defaults = "uid=$UID,gid=$GID,umask=022";
        exfat_defaults = "uid=$UID,gid=$GID,umask=022";
      };
    };
  };
security = {
    soteria.enable = true;
    polkit.enable = true;
    rtkit.enable = true;  # Для pipewire
  };
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

