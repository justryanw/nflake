{
  config,
  lib,
  firefox-addons,
  pkgs,
  ...
}: let
  cfg = config.modules.firefox;
in {
  options.modules.firefox = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        search = {
          force = true;
          engines = {
            mynixos = {
              name = "MyNixOS";
              urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
              definedAliases = ["@n"];
              iconMapObj."16" = "https://mynixos.com/favicon.ico";
            };
            brave = {
              name = "Brave";
              urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
              definedAliases = ["@b"];
              iconMapObj."16" = "https://brave.com/favicon.ico";
            };
            bing.metaData.hidden = true;
          };
        };
        extensions = {
          force = true;
          packages = with firefox-addons.packages.${pkgs.system}; [ublock-origin bitwarden];
        };
        settings = {
          "browser.startup.homepage" = "about:home";

          # Disable irritating first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = false;

          # Disable crappy home activity stream page
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;

          # Disable "save password" prompt
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}
