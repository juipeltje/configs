# NixOS nix settings ( flakes, cachix, )

{ config, pkgs, ... }:

{
  # Enable flakes and additional cachix servers.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://ezkea.cachix.org/" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
}
