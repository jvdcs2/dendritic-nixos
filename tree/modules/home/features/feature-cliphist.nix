{
  flake.modules.homeManager.feature-cliphist = {
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
