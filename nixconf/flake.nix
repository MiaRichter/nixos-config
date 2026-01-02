{
  description = "NixOS configuration with zapret-discord-youtube";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    yandex-browser = { url = "github:miuirussia/yandex-browser.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-plymouth.url = "github:BeatLink/nixos-plymouth";
  };

  outputs = { self, nixpkgs, zapret-discord-youtube, nixos-plymouth,... }: {
    nixosConfigurations.alice = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        nixos-plymouth.nixosModules.default  
        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT)";
          };
        }
      ];
    };
  };
}
