{
  flake.modules.homeManager.feature-vicinae-keyd-bridge = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "vicinae-keyd-bridge";
        runtimeInputs = [pkgs.jq pkgs.procps pkgs.keyd pkgs.niri];
        text = ''
          APP_CONF="$HOME/.config/keyd/app.conf"
          NS="vicinae"

          is_open() {
            niri msg -j layers \
              | jq -e --arg ns "$NS" '[.. | objects | select(.namespace? == $ns)] | length > 0' \
              >/dev/null
          }

          if is_open; then
            vicinae toggle
            mapper_pid="$(pgrep -f keyd-application-mapper || true)"
            [ -n "$mapper_pid" ] && kill -USR1 "$mapper_pid"
          else
            mapfile -t binds < <(awk '
              /^\[\*vicinae\*\]/ { flag=1; next }
              /^\[/               { flag=0 }
              flag && NF && $0 !~ /^#/
            ' "$APP_CONF")

            if [ "''${#binds[@]}" -gt 0 ]; then
              keyd bind reset "''${binds[@]}"
            else
              keyd bind reset
            fi
            vicinae toggle
          fi
        '';
      })
    ];
  };
}
