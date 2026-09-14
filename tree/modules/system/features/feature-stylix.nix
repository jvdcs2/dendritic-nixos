{inputs, ...}: {
  flake.modules.nixos = {
    feature-stylix = {pkgs, ...}: {
      imports = [
        inputs.stylix.nixosModules.default
      ];
      stylix = {
        enable = true;
        polarity = "dark";
        targets = {
          gtk.enable = true;
          qt.platform = pkgs.lib.mkForce "qtct";
        };
      };
    };
  };
}
