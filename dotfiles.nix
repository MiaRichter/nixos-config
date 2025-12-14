# ~/nixos-config/dotfiles.nix
{ config, lib, pkgs, ... }:

{
  # Создаем systemd service для пользователя
  systemd.user.services.setup-dotfiles = {
    description = "Setup dotfiles symlinks";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${./setup-symlinks.sh}";
      RemainAfterExit = true;
      User = "akane";
    };
  };
}