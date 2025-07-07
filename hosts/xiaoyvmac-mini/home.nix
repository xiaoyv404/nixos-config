{
  config,
  pkgs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    outputs.modules.home-manager.users.xiaoyv
  ];
  programs.alacritty = {
    enable = true;
  };
  home = {
    stateVersion = "25.05";
    username = "xiaoyv";
    homeDirectory = lib.mkForce "/Users/xiaoyv";
  };

  programs.home-manager.enable = true;
}
