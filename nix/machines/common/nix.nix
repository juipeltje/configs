# Home Manager Nix configuration ( flakes, cachix, )

{ config, inputs, pkgs, ... }:

{
  # Set nix package to use, and enable flakes and additional cachix servers.
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-trusted-substituters = [
        "https://ezkea.cachix.org/"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
      ];

      extra-trusted-public-keys = [
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };
  };

  # create .nix_profile file which export NIX_PATH variable for nixd language server.
  home.file.".nix_profile" = {
    enable = true;
    executable = true;
    text = ''
      export NIX_PATH=/home/joppe/.nix-defexpr/channels:nixpkgs=${inputs.nixpkgs}
    '';
  };
}
