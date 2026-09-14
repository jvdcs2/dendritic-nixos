{...}: {
  flake.modules.nixos.feature-sway = {...}: {
    programs.sway.enable = true;
  };
}
