{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
  };

  zramSwap.enable = true;

  time.timeZone = "Asia/Shanghai";

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
      X11Forwarding = true;
    };
    openFirewall = true;
  };

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    nixVersions.latest
    just
    nix-output-monitor
    nh
  ];
}
