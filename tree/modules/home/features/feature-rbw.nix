{
  flake.modules.homeManager.feature-rbw = {
    programs.rbw = {
      enable = true;
      settings = {
        email = "javedcorreossial@gmail.com";
        lock_timeout = 1 * 60; # cache timeout in n * 60 secs
      };
    };
  };
}
