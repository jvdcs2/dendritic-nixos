{inputs, ...}: {
  flake.modules.nixos.feature-lean = {pkgs, ...}: {
    nixpkgs.overlays = [
      (
        inputs.lean4-nix.readToolchain
        {
          toolchain = "leanprover/lean4:v4.11.0";
          binary = true;
        }
      )
    ];
    environment.systemPackages = with pkgs; [
      lean.lean-all
      elan
    ];
  };
}
