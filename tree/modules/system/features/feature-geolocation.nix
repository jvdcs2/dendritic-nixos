{
  flake.modules.nixos.feature-geolocation = {lib, ...}: {
    services.geoclue2 = {
      enable = true;
      enableDemoAgent = lib.mkForce true;
      appConfig.firefox = {
        isAllowed = true;
        isSystem = false;
      };
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
