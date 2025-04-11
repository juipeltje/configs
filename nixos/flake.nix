{
  description = "juipeltje's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes = { 
      url = "github:AdisonCavani/distro-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, aagl, hyprland, home-manager, distro-grub-themes, nixgl, nur, ... } @ inputs: 
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
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default ]; }
          ./machines/workstation/configuration.nix
          distro-grub-themes.nixosModules.${system}.default
          aagl.nixosModules.default
        ];
      };

      NixOS-Lappie = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default ]; }
          ./machines/laptop/configuration.nix
          distro-grub-themes.nixosModules.${system}.default
          aagl.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      "joppe@NixOS-Rig" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { 
          inherit inputs;
          hostName = "NixOS-Rig";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default ]; }
          ./machines/workstation/home-manager/home.nix
        ];
      };

      "joppe@NixOS-Lappie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { 
          inherit inputs;
          hostName = "NixOS-Lappie";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default ]; }
          ./machines/laptop/home-manager/home.nix
        ];
      };
      
      "deck@Deckie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { 
          inherit inputs;
          hostName = "Deckie";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default ]; }
          ./machines/steam-deck/home-manager/home.nix
        ];
      };
    };
  };
}
