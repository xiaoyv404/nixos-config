{
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    outputs.modules.home-manager.users.xiaoyv
  ];

  home.packages = with pkgs; [
    nixd
  ];

  programs.fuzzel = {
    enable = true;
    # 可选：自定义配置（如主题、快捷键等）
    settings = {
      main = {
        layer = "overlay";
        width = 40;
        lines = 10;
      };
      colors = {
        background = "282828ff";
        text = "ebdbb2ff";
        selection = "d79921ff";
      };
    };
  };
  programs.alacritty = {
    enable = true;
  };
  programs.mako = {
    enable = true;
  };
  dconf.settings = {
    "org/gnome/mutter/wayland" = {
      xwayland-allow-grabs = true;
      xwayland-grab-access-rules = ["parsecd"];
    };
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
