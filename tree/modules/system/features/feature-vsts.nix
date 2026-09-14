{
  flake.modules.nixos.feature-vsts = {
    pkgs,
    lib,
    ...
  }: let
    pluginPath = fmt: lib.makeSearchPath fmt ["/run/current-system/sw/lib"];
  in {
    environment.systemPackages = with pkgs; [
      surge-XT
      odin2
      dexed
      helm
      yoshimi
      # amsynth
      geonkick
      cardinal
    ];

    # lets any LV2/VST3/CLAP host (DAW) find these without manual scanning
    environment.variables = {
      LV2_PATH = pluginPath "lv2";
      VST3_PATH = pluginPath "vst3";
      CLAP_PATH = pluginPath "clap";
    };
  };
}
