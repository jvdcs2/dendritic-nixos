{inputs, ...}: {
  flake.modules.homeManager.feature-noctaliaShellV5 = {...}: {
    imports = [
      inputs.noctalia-shell-v5.homeModules.default
    ];
    programs.noctalia = {
      enable = true;
    };
  };
}
