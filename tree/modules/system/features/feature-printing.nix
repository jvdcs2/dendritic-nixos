{
  flake.modules.nixos.feature-printing = {pkgs, ...}: {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        cups-filters
      ];
    };
  };
}
