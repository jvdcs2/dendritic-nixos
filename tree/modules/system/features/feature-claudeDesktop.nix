{inputs, ...}: {
  flake.modules.nixos.feature-claudeDesktop = {...}: {
    imports = [
      inputs.claude-desktop.nixosModules.default
    ];
    programs.claude-desktop.enable = true;
    programs.claude-desktop.cowork.kvmUsers = ["alice"];

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
