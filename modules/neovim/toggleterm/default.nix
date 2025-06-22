{ config, ... }:
{
  plugins.toggleterm = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = [
          "ToggleTerm"
          "TermSelect"
        ];
      };
    };
    settings = {
      autochdir = true;
      float_opts.border = "${config.nvix.border}";
      size = ''
        function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end
      '';
    };
  };

  imports = [ ./mappings.nix ];
}
