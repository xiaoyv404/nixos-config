{
    config,
    lib,
    outputs,
    inputs,
    ...
}:{
            system.stateVersion = 6;
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
}