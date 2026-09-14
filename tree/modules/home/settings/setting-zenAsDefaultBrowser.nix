{inputs, ...}: {
  flake.modules.homeManager.setting-zenAsDefaultBrowser = {system, ...}: {
    home.sessionVariables = let
      p = inputs.zen-browser-flake.packages.${system}.default;
    in {
      BROWSER = "${p}/bin/zen";
      DEFAULT_BROWSER = "${p}/bin/zen";
    };

    # xdg.configFile."mimeapps.list".force = true;

    # xdg.mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "text/html" = "zen.desktop";
    #     "x-scheme-handler/http" = "zen.desktop";
    #     "x-scheme-handler/https" = "zen.desktop";
    #     "x-scheme-handler/about" = "zen.desktop";
    #     "x-scheme-handler/unknown" = "zen.desktop";
    #     "x-scheme-handler/chrome" = "zen.desktop";
    #     "application/xhtml+xml" = "zen.desktop";
    #     "application/x-extension-htm" = "zen.desktop";
    #     "application/x-extension-html" = "zen.desktop";
    #     "application/x-extension-shtml" = "zen.desktop";
    #     "application/x-extension-xhtml" = "zen.desktop";
    #     "application/x-extension-xht" = "zen.desktop";
    #   };
    # };
  };
}
