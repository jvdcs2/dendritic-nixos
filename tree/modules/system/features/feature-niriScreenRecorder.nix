{inputs, ...}: {
  flake.modules.nixos.feature-niriScreenRecorder = {
    imports = [
      inputs.niri-screen-recorder.nixosModules.default
    ];

    programs.gpu-screen-recorder.enable = true;
    services.niri-screen-recorder.enable = true;
  };
}
