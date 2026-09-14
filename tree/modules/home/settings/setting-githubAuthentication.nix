{
  flake.modules.homeManager.setting-githubAuthentication = {
    services.ssh-agent.enable = true;

    programs.ssh = {
      enableDefaultConfig = false;
      enable = true;
      settings."*".AddKeysToAgent = "yes"; # tell SSH to automatically add unlocked key agent
    };
  };
}
