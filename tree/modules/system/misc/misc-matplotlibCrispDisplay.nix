{
  flake.modules.nixos.misc-matplotlibCrispDisplay = {...}: {
    environment.sessionVariables.IPYTHONDIR = "/etc/ipython";
    environment.etc."ipython/profile_default/ipython_kernel_config.py".text = ''
      c = get_config()
      c.InlineBackend.figure_format = 'retina'
    '';
  };
}
