{
  inputs,
  lib,
  stdenv,
  ...
}: {
  config = {
    _module.args = {
      inherit (inputs.self) library modules helpers;
    };

    flake.library = {
      createNixosSystem = system: name: {
        ${name} = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            inputs.self.modules.nixos."host-${name}"
            {
              nixpkgs.hostPlatform = lib.mkDefault system;
            }
          ];
          specialArgs = {inherit inputs system;};
        };
      };

      defineHostModule = {
        name,
        isoVersion,
        imports,
      }: {
        nixos."host-${name}" = {
          networking.hostName = name;
          system.stateVersion = isoVersion;
          inherit imports;
        };
      };

      defineUserModule = {
        name,
        homeManagerVersion,
        shell,
        groups,
        imports,
      }: {
        nixos."user-${name}" = {pkgs, ...}: {
          home-manager.users.${name} = {
            imports = [
              inputs.self.modules.homeManager.${name}
            ];
          };

          users.groups.${name} = {};
          users.users.${name} = {
            isNormalUser = true;
            extraGroups = groups;
            shell = shell pkgs;
            group = name;
          };
        };

        homeManager.${name} = {
          inherit imports;
          home = {
            username = name;
            homeDirectory = "/home/${name}";
            stateVersion = homeManagerVersion;
          };
        };
      };
    };
  };
}
