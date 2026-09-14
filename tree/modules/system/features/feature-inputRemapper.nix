{...}: {
  flake.modules.nixos.feature-inputRemapper = {...}: {
    services.input-remapper.enable = true;
  };
}
