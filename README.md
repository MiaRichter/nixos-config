# NixOS Configuration
# обновить системы без ошибок не ломая главный
``` sudo nixos-rebuild switch --no-flake --option experimental-features 'nix-command flakes' -I nixos-config=/home/akane/nixos-config/configuration.nix```