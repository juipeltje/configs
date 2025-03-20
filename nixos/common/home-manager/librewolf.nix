# NixOS Librewolf settings

{ config, pkgs, ... }:

{
  # Enable Librewolf.
  programs = {
    librewolf = {
      enable = true;
      package = pkgs.librewolf;
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
      };

      profiles = {
        default = {
          id = 0;
          isDefault = true;
          name = "default";
          search = {
            default = "Brave";
            privateDefault = "Brave";
            force = true;
            engines = {
              "Brave" = {
                urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
                iconMapObj."30" = "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/brave-browser-icon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@brave" ];
              };
            };
          };
        };
      };
    };
  };
}
