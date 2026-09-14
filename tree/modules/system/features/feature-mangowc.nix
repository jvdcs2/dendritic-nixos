{...}: {
  flake.modules.nixos.feature-mangowc = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.mangowc
    ];
  };
}
