{
  flake.modules.nixos.feature-bitwarden = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bitwarden-desktop
      vaultwarden
      rbw
      pinentry-curses #required for rbw
    ];
  };
}
