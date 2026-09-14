{inputs, ...}: {
  flake.modules.homeManager.feature-neovim = {
    system,
    pkgs,
    ...
  }: {
    home.packages = [
      # inputs.neovim-nightly-overlay.packages.${system}.default
      pkgs.neovim
    ];
  };
}
