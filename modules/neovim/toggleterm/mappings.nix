{ config, helpers, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap wKeyObj;
in
{
  wKeyList = [
    (wKeyObj [
      "<leader>t"
      ""
      "terminal"
    ])
  ];

  keymaps = [
    (mkKeymap "n" "<leader>tf" "<Cmd>ToggleTerm direction=float<CR>" "Open floating terminal")
    (mkKeymap "n" "<leader>th" "<Cmd>ToggleTerm direction=horizontal<CR>" "Open horizontal terminal")
    (mkKeymap "n" "<leader>tv" "<Cmd>ToggleTerm direction=vertical<CR>" "Open vertical terminal")
    (mkKeymap "n" "<C-`>" "<Cmd>execute v:count . 'ToggleTerm'<CR>" "Toggle terminal")
    (mkKeymap "t" "<C-`>" "<Cmd>ToggleTerm<CR>" "Toggle terminal")
    (mkKeymap "i" "<C-`>" "<Esc><Cmd>ToggleTerm<CR>" "Toggle terminal")
    (mkKeymap "t" "<Esc><Esc>" "<C-\\><C-n>" "Switch to normal mode")
    (mkKeymap "n" "<leader>tn" (helpers.mkRaw ''
      function()
        local curterm = require("toggleterm.terminal").get_focused_id()

        if curterm ~= nil then
          vim.cmd(curterm .. "ToggleTermSetName")
        end
      end
    '') "Rename current terminal")
    (mkKeymap "n" "<leader>tl" "<Cmd>TermSelect<CR>" "List terminals")
  ]; # Reference: https://github.com/nicolas-goudry/nixvim-config/blob/1ff2f4e92971f8afa027219f909373ff04147520/plugins/toggleterm.nix
}
