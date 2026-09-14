{
  flake.modules.homeManager.feature-mprisProxy = {
    services.mpris-proxy = {
      enable = true;
    };
  };
}
