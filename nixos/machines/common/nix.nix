# NixOS nix configuration ( flakes, cachix, )

{ config, pkgs, ... }:

{
  # Enable flakes and additional cachix servers.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ 
      "https://ezkea.cachix.org/"
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [ 
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" 
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
