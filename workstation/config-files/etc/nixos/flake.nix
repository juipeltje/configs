{
  description = "workstation flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }: 
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
    nixosConfigurations.NixOS-Rig = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
        ./configuration.nix 
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
