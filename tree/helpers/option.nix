{lib, ...}: {
  options.flake.helpers = lib.mkOption {
    # so that flake.helpers.<...> wont compete but merge.
    type = lib.types.attrsOf lib.types.raw;
    default = {};
    description = "Custom helper functions";
  };
}
