{
  flake.modules.nixos.setting-sleepFix = {
    lib,
    pkgs,
    ...
  }: {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;

    boot.kernelParams = ["mem_sleep_default=s2idle"];
    systemd.sleep.settings.Sleep.MemorySleepMode = "s2idle";

    systemd.tmpfiles.rules = ["w /sys/power/pm_async - - - - 0"];
  };
}
