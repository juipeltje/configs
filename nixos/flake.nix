{
  description = "flake for my NixOS machines";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes = { 
      url = "github:AdisonCavani/distro-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, distro-grub-themes, aagl, nixgl, ... } @ inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
    nixosConfigurations = {
      NixOS-Rig = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ 
          { nixpkgs.overlays = [ overlay-unstable ]; }
          ./workstation/configuration.nix
          distro-grub-themes.nixosModules.${system}.default
          aagl.nixosModules.default
        ];
      };

      NixOS-Lappie = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay-unstable ]; }
          ./laptop/configuration.nix
          distro-grub-themes.nixosModules.${system}.default
          aagl.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      "joppe@NixOS-Rig" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay-unstable ]; }
          ./workstation/home-manager/home.nix
        ];
      };

      "joppe@NixOS-Lappie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay-unstable ]; }
          ./laptop/home-manager/home.nix
        ];
      };
      
      "deck@Deckie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay-unstable ]; }
          ./steam-deck/home-manager/home.nix
        ];
      };
    };
  };
}
