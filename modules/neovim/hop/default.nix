{
  plugins.hop = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = [ "HopWord" ];
      };
    };
  };

  imports = [ ./mappings.nix ];
}
