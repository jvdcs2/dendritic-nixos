{
  flake.modules.nixos = {
    setting-stylix-fonts-sleek = {pkgs, ...}: let
      fixMetrics = pkgs.writeText "fix-vertical-metrics.py" ''
        import sys
        from fontTools.ttLib import TTFont

        for path in sys.argv[1:]:
            font = TTFont(path)
            hhea, os2 = font["hhea"], font["OS/2"]
            total = hhea.ascent - hhea.descent + hhea.lineGap
            cap = getattr(os2, "sCapHeight", 0) or hhea.ascent
            asc = round((total + cap) / 2)
            desc = asc - total
            hhea.ascent, hhea.descent, hhea.lineGap = asc, desc, 0
            os2.sTypoAscender, os2.sTypoDescender, os2.sTypoLineGap = asc, desc, 0
            os2.usWinAscent, os2.usWinDescent = asc, -desc
            font.save(path)
      '';

      helveticaFixed =
        pkgs.runCommand "helvetica-neue-lt-std-fixed" {
          nativeBuildInputs = [(pkgs.python3.withPackages (ps: [ps.fonttools]))];
        } ''
          cp -rL --no-preserve=mode ${pkgs.helvetica-neue-lt-std} $out
          find $out -type f \( -iname '*.otf' -o -iname '*.ttf' \) -print0 \
            | xargs -0 python3 ${fixMetrics}
        '';
    in {
      stylix.fonts = {
        serif = {
          package = pkgs.texlivePackages.eczar;
          name = "Eczar";
        };

        sansSerif = {
          package = helveticaFixed;
          name = "HelveticaNeueLT Std Med";
          # package = pkgs.dm-sans;
          # name = "DeepMind Sans Medium";
        };

        monospace = {
          package = pkgs.ioskeley-mono.normal-NF;
          name = "IoskeleyMonoNL Nerd Font Medium";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
