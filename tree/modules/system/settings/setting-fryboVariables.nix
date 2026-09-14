{
  flake.modules.nixos.setting-fryboVariables = {...}: {
    environment.sessionVariables = {
      PATH = [
        "$HOME/.emacs.d/bin"
        "$HOME/.cargo/bin"
      ];

      VISUAL = "nvim";
      EDITOR = "nvim";
      # VISUAL = "hx";
      # EDITOR = "hx";
      LSP_USE_PLISTS = "true";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";

      # QT_SCALE_FACTOR = "0.85"; # vals <1 breaks visuals
      # QT_FONT_DPI = "96"; # added to fix vicinae font size, might be better to set individually

      LIBVA_DRIVER_NAME = "iHD";

      EZA_COLORS = builtins.concatStringsSep ":" [
        "ur=33"
        "uw=33"
        "ux=33"
        "gr=35"
        "gw=35"
        "gx=35"
        "tr=90"
        "tw=90"
        "tx=90"
      ];

      FZF_DEFAULT_OPTS = builtins.concatStringsSep " " [
        "--padding=0,1"
        "--style=full"
        "--cycle"
        "--gutter=' '"

        "--color=input-border:white"
        "--color=input-label:white"
        "--color=preview-fg:white"
        "--color=fg:240"

        "--color=bg:-1"

        "--color=current-bg:-1"
        "--color=border:bright-black"
        "--color=info:magenta"
        "--color=pointer:cyan"

        "--color=marker:blue"
        "--color=hl:green"

        "--list-label='> matches <'"
        "--preview-label='> info <'"
        "--input-label='> input <'"
      ];
    };
  };
}
