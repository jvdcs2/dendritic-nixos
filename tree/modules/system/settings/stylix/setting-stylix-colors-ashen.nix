{
  flake.modules.nixos = {
    setting-stylix-colors-ashen = {
      stylix.base16Scheme = {
        base00 = "121212"; # background
        base01 = "1d1d1d"; # g_10 (lighter bg / status bars)
        base02 = "323232"; # g_8 (selection)
        base03 = "737373"; # g_6 (comments / muted)
        base04 = "949494"; # g_5 (dark foreground)
        base05 = "b4b4b4"; # text (default foreground)
        base06 = "d5d5d5"; # g_2 (light foreground)
        base07 = "e5e5e5"; # g_1 (light background)
        base08 = "C53030"; # red_flame (variables / error)
        base09 = "C4693D"; # orange_blaze (integers / constants)
        base0A = "E5A72A"; # orange_golden (classes / search text)
        base0B = "4A8B8B"; # blue (mapped to Green / strings - closest match)
        base0C = "4A8B8B"; # blue (mapped to Cyan / support - exact match)
        base0D = "4A8B8B"; # blue (mapped to Blue / functions - exact match)
        base0E = "DF6464"; # red_glowing (mapped to Magenta / keywords - closest pinkish match)
        base0F = "89492a"; # brown (deprecated / misc tags)
      };
    };
  };
}
