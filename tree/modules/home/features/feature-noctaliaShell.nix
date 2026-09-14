{inputs, ...}: {
  flake.modules.homeManager.feature-noctaliaShell = {...}: {
    imports = [
      inputs.noctalia-shell.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
    };
  };
}
