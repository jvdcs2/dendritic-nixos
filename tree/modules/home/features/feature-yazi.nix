{inputs, ...}: {
  flake.modules.homeManager.feature-yazi = {
    pkgs,
    system,
    ...
  }: {
    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      package = inputs.yazi.packages.${system}.default;
      plugins = {
        inherit
          (pkgs.yaziPlugins)
          full-border
          toggle-pane
          smart-enter
          mediainfo
          vcs-files
          restore
          yatline
          duckdb
          mount
          sudo
          ouch

          smart-filter
          # starship
          chmod
          piper
          ;
      };
    };
  };
}
