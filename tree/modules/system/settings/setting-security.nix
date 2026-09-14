{
  flake.modules.nixos.setting-security = {
    security.sudo.wheelNeedsPassword = false;
    security.polkit.enable = true;
    security.rtkit.enable = true;
    security.sudo.enable = true;
  };
}
