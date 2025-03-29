{ nvix, lib, ... }:
{
  imports = [ nvix.nvixModules.snacks ];

  plugins.snacks.settings = {
    scroll.enabled = lib.mkForce false;
  };
}
