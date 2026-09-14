{
  library, #
  ...
}:
with library; {
  flake.nixosConfigurations = (
    {}
    // (createNixosSystem "x86_64-linux" "frybo")
  );
}
