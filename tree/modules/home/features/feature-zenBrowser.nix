{inputs, ...}: {
  flake.modules.homeManager.feature-zenBrowser = {
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.zen-browser-flake.homeModules.default];

    # `zen` command, pointing at the copy of Zen that has your policies built in
    home.packages = [
      (pkgs.runCommand "zen-compat" {} ''
        mkdir -p $out/bin
        ln -s ${config.programs.zen-browser.finalPackage}/bin/zen-beta $out/bin/zen
      '')
    ];

    programs.zen-browser = {
      enable = true;
      profiles.alice.mods = [
        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
      ];
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
        # Use the system file picker (yazi) instead of Zen's GTK dialog
        Preferences."widget.use-xdg-desktop-portal.file-picker" = {
          Value = 1;
          Status = "locked";
        };
      };
    };
  };
}
