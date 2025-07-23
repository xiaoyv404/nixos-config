{
  config,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    outputs.modules.home-manager.users.xiaoyv
  ];

  home.packages = with pkgs; [
    nixd
  ];

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
