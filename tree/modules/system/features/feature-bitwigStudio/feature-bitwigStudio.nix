{
  flake.modules.nixos.feature-bitwigStudio = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.callPackage ./_bitwig.nix {
        debFile = /opt/nix-blobs/bitwig/bitwig-studio-6.1.deb;
        jarOverride = /opt/nix-blobs/bitwig/bitwig.jar;
        jarOverrideTarget = "bitwig.jar";
      })
    ];
  };
}
