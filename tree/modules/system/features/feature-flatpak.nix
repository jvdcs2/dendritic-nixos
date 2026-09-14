{
  #  inputs,
  ...
}: {
  flake.modules.nixos.feature-flatpak = {
    # pkgs,
    # system,
    ...
  }: {
    services.flatpak.enable = true;
  };
}
