{inputs, ...}: {
  flake.modules.homeManager.feature-emacs = {
    system,
    ...
  }: {
    home.packages = [
      inputs.emacs-overlay.packages.${system}.emacs-unstable-pgtk
    ];

    services.emacs = {
      enable = true;
      package = inputs.emacs-overlay.packages.${system}.emacs-unstable-pgtk;
    };
  };
}
