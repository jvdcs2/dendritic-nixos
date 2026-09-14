{...}: {
  flake.modules.nixos.feature-labwc = {...}: {
    programs.labwc.enable = true;
  };
}
