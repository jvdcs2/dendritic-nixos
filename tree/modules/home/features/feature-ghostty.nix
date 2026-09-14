{...}: {
  flake.modules.homeManager.feature-ghostty = {...}: {
    programs.ghostty = {
      enable = true;

      # Installs & links the shipped app-com.mitchellh.ghostty.service unit,
      # and registers Ghostty's D-Bus service file so `+new-window` can use
      # D-Bus activation. Already defaults to true on Linux, but explicit
      # here for clarity.
      systemd.enable = true;
      settings = {
        gtk-single-instance = true;
        quit-after-last-window-closed = false;
        # initial-window = false;

        confirm-close-surface = false;
        link-previews = true;
        adjust-cell-height = 3;
        font-size = 11;
        cursor-style-blink = false;
        window-decoration = false;
        window-padding-x = 8;
        window-padding-y = 5;
        term = "xterm-256color";

        # cursor flash fix attempt (useless so far)
        synchronize-modifiers = true;
        vsync = true;
        fps-limit = 119; # just below 120

        # manually set because stylix ghostty target is broken
        # font-family = "IoskeleyMono Nerd Font Medium";
        font-family = "IoskeleyMonoNL Nerd Font Medium";
        background = "#1a1a19";
        foreground = "#d1d1d1";
        cursor-color = "#d1d1d1";
        selection-background = "#323231";
        selection-foreground = "#d1d1d1";
        palette-generate = false;
        palette = [
          "0=#1a1a19"
          "1=#ff968c"
          "2=#60967d"
          "3=#ffc591"
          "4=#86adcd"
          "5=#de9bc8"
          "6=#499294"
          "7=#d1d1d1"
          "8=#323231"
          "9=#ff968c"
          "10=#60967d"
          "11=#ffc591"
          "12=#86adcd"
          "13=#de9bc8"
          "14=#499294"
          "15=#d1d1d1"
          "16=#ffc591"
          "17=#ff968c"
          "18=#222221"
          "19=#323231"
          "20=#767675"
          "21=#d1d1d1"
        ];

        keybind = [
          "ctrl+u=unbind"
          "ctrl+d=unbind"
          "ctrl+shift+r=unbind"
          "ctrl+shift+d=unbind"
          "ctrl+shift+w=unbind"
          "ctrl+shift+u=unbind"
          "ctrl+shift+n=unbind"
          "ctrl+shift+h=unbind"
          "ctrl+shift+l=unbind"
          "ctrl+shift+k=scroll_page_lines:-1"
          "ctrl+shift+j=scroll_page_lines:1"
          "all:ctrl+equal=increase_font_size:1"
          "all:ctrl+minus=decrease_font_size:1"
        ];
      };
    };
  };
}
