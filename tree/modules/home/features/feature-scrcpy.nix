{
  flake.modules.nixos.feature-scrcpy = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [scrcpy android-tools];
    users.users.alice.extraGroups = ["adbusers"];
  };
}
