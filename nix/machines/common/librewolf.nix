# Home Manager Librewolf configuration

{ config, pkgs, ... }:

{
  # Enable Librewolf.
  programs = {
    librewolf = {
      enable = true;
      package = pkgs.librewolf;
      settings = {
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "browser.startup.homepage" = "https://duckduckgo.com/?t=ffab";
      };

      profiles = {
        default = {
          id = 0;
          isDefault = true;
          name = "default";
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin tridactyl ];
          search = {
            default = "ddg";
            privateDefault = "ddg";
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
