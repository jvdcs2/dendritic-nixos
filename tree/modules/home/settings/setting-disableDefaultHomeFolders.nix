{
  flake.modules.homeManager.setting-disableDefaultHomeFolders = {
    xdg.userDirs = {
      enable = false;
      createDirectories = false;
    };
  };
}
