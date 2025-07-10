{
  config,
  lib,
  outputs,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    {
      # home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.users.xiaoyv = import ./home.nix;
    }
    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "xiaoyv";
        autoMigrate = true;
      };
    }
    outputs.modules.base.ca
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
  system = {
    stateVersion = 6;
    primaryUser = "xiaoyv";
  };

  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
    optimise.automatic = true;
    gc = {
      automatic = true;

      options = "--delete-older-than 14d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
  };
  users = {
    knownUsers = [ "xiaoyv" ];
    users.xiaoyv = {
      uid = 501;
      shell = pkgs.fish;
    };
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    nixVersions.latest
    just
    nix-output-monitor
    nh
    nixfmt-rfc-style
    alacritty
    zulu17
    zulu21
  ];

  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };
  homebrew = {
    enable = true;
    brews = [
      "zstd"
    ];
    casks = [
      "battery-toolkit"
      "jordanbaird-ice"
      "linearmouse"
      "moonlight"
      "openinterminal"
      "pearcleaner"
      "stats"
      "visual-studio-code"
      "maccy"
    ];
  };
}
