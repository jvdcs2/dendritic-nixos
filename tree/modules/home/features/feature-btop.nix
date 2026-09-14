{...}: {
  flake.modules.homeManager.feature-btop = {
    stylix.targets.btop.enable = false;
    programs.btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = true;
        # force_tty = true;

        # Presets
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";

        # Navigation
        vim_keys = true;
        rounded_corners = true;

        # Graph settings
        graph_symbol = "braille";
        graph_symbol_cpu = "default";
        graph_symbol_gpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";

        # Display
        shown_boxes = "cpu mem net proc";
        update_ms = 400;

        # Process settings
        proc_sorting = "cpu direct";
        proc_reversed = false;
        proc_tree = false;
        proc_colors = true;
        proc_gradient = true;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = true;
        proc_left = false;
        proc_filter_kernel = false;
        proc_aggregate = false;

        # CPU settings
        cpu_graph_upper = "Auto";
        cpu_graph_lower = "Auto";
        show_gpu_info = "Auto";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_uptime = true;
        show_cpu_watts = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        cpu_core_map = "";
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        clock_format = "%X";
        background_update = true;
        custom_cpu_name = "";

        # Disk settings
        disks_filter = "";
        mem_graphs = true;
        mem_below_net = false;
        zfs_arc_cached = true;
        show_swap = true;
        swap_disk = true;
        show_disks = true;
        only_physical = true;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graph_combined = false;
        io_graph_speeds = "";

        # Network settings
        net_download = 100;
        net_upload = 100;
        net_auto = true;
        net_sync = true;
        net_iface = "";
        base_10_bitrate = "Auto";

        # Battery
        show_battery = true;
        selected_battery = "Auto";
        show_battery_watts = true;

        # Logging
        log_level = "WARNING";

        # GPU settings
        nvml_measure_pcie_speeds = true;
        rsmi_measure_pcie_speeds = true;
        gpu_mirror_graph = true;
        custom_gpu_name0 = "";
        custom_gpu_name1 = "";
        custom_gpu_name2 = "";
        custom_gpu_name3 = "";
        custom_gpu_name4 = "";
        custom_gpu_name5 = "";
      };
    };
  };
}
