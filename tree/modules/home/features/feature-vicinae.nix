{inputs, ...}: {
  flake.modules.homeManager.feature-vicinae = {
    system,
    lib,
    ...
  }: {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    #set to programs.vicinae = ... for newest flake
    #set to services.vicinae = ... for oldflake
    services.vicinae = {
      enable = true;
      package = inputs.vicinae.packages.${system}.default;
      systemd = {
        enable = true;
        autoStart = true;
        environment = {
          USE_LAYER_SHELL = 1;
          # QT_FONT_DPI = "96";
        };
      };
      settings = {
        imports = [];
        close_on_focus_loss = true;
        consider_preedit = false;
        pop_to_root_on_close = false;
        show_results_on_empty_query = true;
        escape_key_behavior = "navigate_back";
        favicon_service = "twenty";
        search_files_in_root = false;
        font = {
          normal = {
            family = "DeepMind Sans Medium";
            size = 12;
          };
        };
        theme = {
          light = {
            name = lib.mkForce "stylix";
            icon_theme = "auto";
          };
          dark = {
            name = lib.mkForce "stylix";
            icon_theme = "auto";
          };
        };
        launcher_window = {
          opacity = lib.mkForce 1;
          client_side_decorations = {
            enabled = true;
            rounding = 10;
            border_width = 1;
          };
          size = {
            width = 800;
            height = 500;
          };
          dim_around = true;
          blur.enabled = true;
          compact_mode.enabled = true;
          layer_shell = {
            layer = "top";
            enabled = true;
          };
        };
        favorites = ["clipboard:history"];
        fallbacks = ["files:search"];
      };
      extensions = with inputs.vicinae-extensions.packages.${system}; [
        process-manager
        niri
        nix

        wifi-commander

        github
      ];
    };
  };
}
