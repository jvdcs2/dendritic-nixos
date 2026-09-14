{inputs, ...}: {
  flake.modules.homeManager.feature-zenBrowser = {
    pkgs,
    system,
    ...
  }: {
    imports = [
      inputs.zen-browser-flake.homeModules.default
    ];

    home.packages = let
      zenPkg = inputs.zen-browser-flake.packages.${system}.default;
    in [
      (pkgs.runCommand "zen-compat" {} ''
        mkdir -p $out/bin
        ln -s ${zenPkg}/bin/zen-beta $out/bin/zen
      '')
    ];

    programs.zen-browser = {
      enable = true;
      profiles.alice = {
        mods = [
          "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
          "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
          "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
        ];
      };
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };
}
