{
  flake.modules.nixos.feature-aria = {pkgs, ...}: {
    services.aria2.enable = true;
  };
}
