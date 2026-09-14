{
  # https://github.com/NixOS/nix/issues/5897
  flake.modules.nixos = let
    pos = builtins.unsafeGetAttrPos "_" {_ = 1;};
    fileName = baseNameOf pos.file;
    nameLen = builtins.stringLength fileName;
    themeName = builtins.substring 0 (nameLen - 4) fileName;
  in {
    "${themeName}" = {pkgs, ...}: {
      stylix.fonts = {
        serif = {
          package = pkgs.texlivePackages.eczar;
          name = "Eczar";
        };

        sansSerif = {
          package = pkgs.dm-sans;
          name = "DeepMind Sans Medium";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JuliaMono Medium";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
