{inputs, ...}: {
  flake.modules.nixos.feature-homarr = {
    imports = [
      inputs.quadlet-nix.nixosModules.quadlet
    ];

    virtualisation.quadlet.enable = true;
    virtualisation.quadlet.containers.homarr = {
      autoStart = true;
      serviceConfig = {
        Restart = "always";
        RestartSec = "10";
      };
      containerConfig = {
        image = "ghcr.io/homarr-labs/homarr:latest";
        # This maps port 7575 on your server to the dashboard
        publishPorts = ["7575:7575"];
        # Persists your settings even if the container is deleted/updated

        environments = {
          SECRET_ENCRYPTION_KEY = "bc548a5fcd19e571212bc2c2b691a435e01e1c6d5d3b6b489dd2b4e4c119153d";
        };

        volumes = [
          "homarr-configs:/app/data/configs"
          "homarr-data:/data"
        ];
      };
    };

    virtualisation.quadlet.volumes.homarr-configs = {};
    virtualisation.quadlet.volumes.homarr-data = {};
  };
}
