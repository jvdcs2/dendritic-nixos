{
  flake.modules.homeManager.feature-halloy = {...}: {
    programs.halloy = {
      enable = true;
    };
  };
}
