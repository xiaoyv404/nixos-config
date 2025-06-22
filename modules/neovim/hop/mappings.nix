{ config, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap;
in
{
  keymaps = [
    (mkKeymap "n" "<leader>h" "<Cmd>HopWord<CR>" "Hop to word")
    (mkKeymap "v" "<leader>h" "<Cmd>HopWord<CR>" "Hop to word")
  ];
}
