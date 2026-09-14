{
  flake.helpers.symlink = {
    from,
    to,
    user,
  }: {...}: {
    system.activationScripts."symlink-${builtins.hashString "sha256" to}" = {
      deps = ["users" "groups"];
      text = ''
        /run/wrappers/bin/su ${user} -s /bin/sh -c '
          find "${from}" -type f | while read -r src; do
            rel="''${src#${from}/}"
            dest="${to}/''${rel}"
            mkdir -p "$(dirname "$dest")"
            ln -sf "$src" "$dest"
          done
        '
      '';
    };
  };
}
