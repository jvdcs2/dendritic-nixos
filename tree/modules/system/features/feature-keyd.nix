{
  flake.modules.nixos.feature-keyd = {pkgs, ...}: {
    users.groups.keyd = {};

    systemd.services.keyd.serviceConfig = {
      Group = "keyd";
      UMask = pkgs.lib.mkForce "0002";
    };

    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        # extraConfig = ''
        #   [ids]
        #   *
        #
        #   [alt+shift]
        #   [meta+control]
        #   [control+alt]
        #
        #   [main]
        #   capslock = overload(control, esc)
        #
        #   [alt]
        #   e        = enter
        #   d        = backspace
        #   w        = C-backspace
        #   b        = C-left
        #   f        = C-right
        # '';
        extraConfig = ''
          [ids]
          *

          [alt+shift]
          [meta+control]
          [control+alt]

          [main]
          capslock = overload(control, esc)

          [alt]
          e        = enter
          d        = backspace
          w        = C-backspace
          f        = C-right
        '';
      };
    };
  };
}
