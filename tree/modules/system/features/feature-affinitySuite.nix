{inputs, ...}:
with inputs.affinity; {
  flake.modules.nixos.feature-affinitySuite = {system, ...}: {
    environment.systemPackages = [
      packages.${system}.default
    ];
  };
}
