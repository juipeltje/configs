# Home Manager Nix configuration ( flakes, cachix, )

{ config, pkgs, ... }:

{
  # Set nix package to use, and enable flakes and additional cachix servers.
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-trusted-substituters = [ 
        "https://ezkea.cachix.org/"
        "https://hyprland.cachix.org"
      ];

      extra-trusted-public-keys = [ 
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" 
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
}
