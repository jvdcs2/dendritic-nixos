{...}: {
  flake.modules.homeManager.feature-kitty = {...}: {
    programs.kitty = {
      enable = true;

      settings = {
        confirm_os_window_close = 0;
        show_hyperlink_targets = "yes";
        open_url_with = "zen";

        modify_font = "cell_height +3px";
        font_size = 11;

        # background_opacity = lib.mkForce "0.8";
        # background_blur = lib.mkForce 1;
        cursor_blink_interval = 0;

        window_padding_width = 6;
      };

      keybindings = {
        "ctrl+u" = "no_op";
        "ctrl+d" = "no_op";
        "ctrl+shift+r" = "no_op";
        "ctrl+shift+d" = "no_op";
        "ctrl+shift+w" = "no_op";
        "ctrl+shift+u" = "no_op";
        "ctrl+shift+n" = "no_op";
        "ctrl+shift+h" = "no_op";
        "ctrl+shift+l" = "no_op";
        "ctrl+shift+e" = "no_op";

        "ctrl+shift+k" = "scroll_line_up";
        "ctrl+shift+j" = "scroll_line_down";

        "ctrl+equal" = "change_font_size all +1.0";
        "ctrl+minus" = "change_font_size all -1.0";
      };
    };
  };
}
