{
  flake.modules.nixos.device-ASUS_Zenbook_14_UX3405MA = {
    modulesPath,
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      (modulesPath + "/hardware/cpu/intel-npu.nix")
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/9e3817fa-fddc-4e7d-aeae-cfd6dae89f41";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/9B3C-C5DF";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.npu.enable = true;
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

    hardware = {
      enableAllFirmware = true;
      enableAllHardware = true;
      graphics.enable = true;
      graphics.extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
        vpl-gpu-rt
        vaapi-intel-hybrid
        libva-vdpau-driver
        libvdpau-va-gl
      ];
      graphics.enable32Bit = true;
      graphics.extraPackages32 = with pkgs.driversi686Linux; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };

    # https://wiki.nixos.org/wiki/Intel_Graphics
    boot.kernelParams = ["i915.force_probe=7d55"];
  };
}
