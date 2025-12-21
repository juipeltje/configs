{
  description = "juipeltje's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    mango.url = "github:DreamMaoMao/mango";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, aagl, hyprland, mango, chaotic, home-manager, nur, ... } @ inputs:
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
    homeConfigurations = {
      "joppe@Void-Rig" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          hostName = "Void-Rig";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default chaotic.overlays.default ]; }
          ./machines/workstation/home.nix
        ];
      };

      "joppe@Void-Server" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          hostName = "Void-Server";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default chaotic.overlays.default ]; }
          ./machines/server/home.nix
        ];
      };

      "joppe@Void-Lappie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          hostName = "Void-Lappie";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default chaotic.overlays.default ]; }
          ./machines/laptop/home.nix
        ];
      };

      "deck@Deckie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          hostName = "Deckie";
        };

        modules = [
          { nixpkgs.overlays = [ overlay-unstable nur.overlays.default chaotic.overlays.default ]; }
          ./machines/deck/home.nix
        ];
      };
    };
  };
}
