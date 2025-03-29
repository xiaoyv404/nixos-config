{ outputs, pkgs, ... }:
{
  extraPlugins = [
    outputs.legacyPackages.${pkgs.system}.neovimPlugins.auto-indent
  ];
  extraConfigLua = ''
    require("auto-indent").setup({
      lightmode = true,        -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
      indentexpr = {
        ---@param lnum: number
        ---@return number
        indentexpr = function(lnum)
          return require("nvim-treesitter.indent").get_indent(lnum)
        end
      },
      ignore_filetype = {},    -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
    })
  '';
}
