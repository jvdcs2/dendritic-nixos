{
  flake.modules.nixos.setting-timezoneLocale = {
    time.timeZone = "Asia/Manila";
    time.hardwareClockInLocalTime = false;
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
