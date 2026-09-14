{
  flake.modules.nixos.setting-disableNiriSessionWarning = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = [
      (lib.hiPrio (pkgs.runCommand "niri-session-quiet" {} ''
        mkdir -p $out/bin

        # Grab the pre-built script from the cached niri package
        cp ${pkgs.niri}/bin/niri-session $out/bin/niri-session
        chmod +w $out/bin/niri-session

        # Mute the warnings
        sed -i 's/systemctl --user import-environment/systemctl --user import-environment >\/dev\/null 2>\&1/g' $out/bin/niri-session
        sed -i 's/dbus-update-activation-environment --all/dbus-update-activation-environment --all >\/dev\/null 2>\&1/g' $out/bin/niri-session
        sed -i 's/systemctl --user unset-environment/systemctl --user unset-environment >\/dev\/null 2>\&1/g' $out/bin/niri-session
      ''))
    ];
  };
}
