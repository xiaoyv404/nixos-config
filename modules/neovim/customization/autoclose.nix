{
  # plugins.autoclose.enable = true; # broken: https://github.com/m4xshen/autoclose.nvim/issues/57
  # plugins.nvim-autopairs = {
  #   enable = true;
  #   settings = {
  #     check_ts = true;
  #     ts_config = {
  #       java = false;
  #     };
  #     fast_wrap = {
  #       map = "<M-e>";
  #       chars = [
  #         "{"
  #         "["
  #         "("
  #         "\""
  #         "'"
  #       ];
  #       offset = 0;
  #       end_key = "$";
  #       keys = "qwertyuiopzxcvbnmasdfghjkl";
  #       check_comma = true;
  #     };
  #   };
  # };
  plugins.treesitter.settings.indent.enable = true;
}
