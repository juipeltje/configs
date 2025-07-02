# Home Manager Librewolf configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Enable Librewolf.
      programs = {
        librewolf = {
          enable = true;
          package = pkgs.librewolf;
          settings = {
            "privacy.clearOnShutdown.history" = true;
            "privacy.clearOnShutdown.downloads" = true;
          };

          profiles = {
            default = {
              id = 0;
              isDefault = true;
              name = "default";
              search = {
                default = "SearXNG";
                privateDefault = "SearXNG";
                force = true;
                engines = {
                  "SearXNG" = {
                    urls = [{ template = "https://searx.tiekoetter.com/search?q={searchTerms}"; }];
                    updateInterval = 24 * 60 * 60 * 1000;
                    definedAliases = [ "@SearXNG" ];
                  };
                };
              };
            };
          };
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig" || "NixOS-Lappie") {
      programs.librewolf.package = pkgs.librewolf;
    })

    (lib.mkIf (hostName == "Deckie") {
      programs.librewolf.package = config.lib.nixGL.wrap pkgs.librewolf;
    })
  ];
}
