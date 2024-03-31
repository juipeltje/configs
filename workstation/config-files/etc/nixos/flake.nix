{
  description = "workstation flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/archive/master.tar.gz";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.NixOS-Rig = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
