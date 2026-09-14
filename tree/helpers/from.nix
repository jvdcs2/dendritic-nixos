{
  flake.helpers.from = newNixpkgs: moduleList: {pkgs, ...} @ args: let
    newPkgs = import newNixpkgs {
      inherit (pkgs) system;
      config = pkgs.config;
    };
    overridePkgsOn = m: m (args // {pkgs = newPkgs;});
  in {
    imports = map overridePkgsOn moduleList;
  };
}
