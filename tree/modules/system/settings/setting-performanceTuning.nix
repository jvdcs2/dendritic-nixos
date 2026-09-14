{
  flake.modules.nixos.setting-performanceTuning = {
    boot = {
      kernelParams = [
        "mitigations=off"
        "panic=10"
        "reboot=cold"
        "audit=0"
        "nowatchdog"
      ];
      kernel.sysctl = {
        "kernel.sched_autogroup_enabled" = 1;
        "kernel.printk" = "3 3 3 3";
        "kernel.hung_task_timeout_secs" = 10;
        "kernel.sched_migration_cost_ns" = 500000;

        "fs.inotify.max_user_watches" = 524288;
        "fs.inotify.max_user_instances" = 524288;
        "fs.inotify.max_queued_events" = 32768;
      };
    };

    systemd.tmpfiles.rules = [
      # decreases hyprland stutter; 1300 is highest min for intel igpu
      "w /sys/class/drm/card1/gt_min_freq_mhz - - - - 1300"
    ];

    services.tlp = {
      enable = true;
      settings = {
        # filesystem
        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 10;
        MAX_LOST_WORK_SECS_ON_AC = 20;
        MAX_LOST_WORK_SECS_ON_BAT = 100;

        # disk
        DISK_APM_LEVEL_ON_AC = "254 254";
        DISK_APM_LEVEL_ON_BAT = "64 64";

        # sound
        SOUND_POWER_SAVE_CONTROLLER = "Y";
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1;

        # battery
        NATACPI_ENABLE = 1;
        TPSMAPI_ENABLE = 1;
        RESTORE_THRESHOLDS_ON_BAT = 1;
        START_CHARGE_THRESH_BAT0 = 60;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # cpu
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        CPU_MIN_PERF_ON_AC = 50;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;
        CPU_SCALING_MIN_FREQ_ON_AC = 2000000;
        CPU_SCALING_MAX_FREQ_ON_AC = 4500000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 0;
        CPU_SCALING_MAX_FREQ_ON_BAT = 800000;

        # kernel
        NMI_WATCHDOG = 0;

        # network
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        WOL_DISABLE = "Y";

        # platform
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        MEM_SLEEP_ON_AC = "s2idle";
        MEM_SLEEP_ON_BAT = "deep";
      };
    };
  };
}
