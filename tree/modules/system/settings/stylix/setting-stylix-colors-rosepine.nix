{
  flake.modules.nixos = {
    setting-stylix-colors-rosepine = {
      stylix.base16Scheme = {
        base00 = "191724"; # base
        base01 = "1f1d2e"; # surface
        # base02 = "36334a"; # overlay
        base02 = "6e6a86"; # overlay
        base03 = "6e6a86"; # muted
        base04 = "908caa"; # subtle
        base05 = "e0def4"; # text
        base06 = "e0def4"; # text (alt)
        base07 = "524f67"; # highlight high
        base08 = "eb6f92"; # love (red)
        base09 = "f6c177"; # gold (orange)
        base0A = "ebbcba"; # rose (yellow)
        base0B = "31748f"; # pine (green)
        base0C = "9ccfd8"; # foam (cyan)
        base0D = "c4a7e7"; # iris (blue)
        base0E = "c4a7e7"; # iris (magenta)
        base0F = "524f67"; # highlight high (brown/alt)
      };
    };
  };
}
