{
  pkgs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    outputs.modules.home-manager.fish
  ];

  nixpkgs.overlays = [
    outputs.overlays.self-defined-packages
  ];

  home.username = "xiaoyv";
  home.homeDirectory = "/home/xiaoyv";

  home.packages = with pkgs; [
    self-defined.neovim
    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    eza # A modern replacement for ‘ls’

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  modules.home-manager.fish.defaultShell = lib.mkDefault true;
  modules.home-manager.fish.wezrs.enable = lib.mkDefault true;

  programs.git = {
    enable = true;
    userName = "xiaoyv_404";
    userEmail = "xiaoyv_404@outlook.com";
    # signing = {
    #   key = "5294C7EFDE9F9284";
    #   signByDefault = true;
    # };
  };
}
