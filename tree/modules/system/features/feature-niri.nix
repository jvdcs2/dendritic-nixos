{inputs, ...}: {
  flake.modules.nixos.feature-niri = {system, ...}: {
    environment.systemPackages = with inputs.niri-flake.packages.${system}; [
      xwayland-satellite-unstable
    ];

    programs.niri = {
      enable = true;
      package = inputs.niri-flake.packages.${system}.niri-unstable;
    };
  };
}
# {inputs, ...}: {
#   flake.modules.nixos.feature-niri = {system, ...}: {
#     environment.systemPackages = with (import inputs.nixpkgs {inherit system;}); [
#       xwayland-satellite
#     ];
#
#     programs.niri = {
#       enable = true;
#       package = inputs.niri-src.packages.${system}.niri;
#     };
#   };
# }
