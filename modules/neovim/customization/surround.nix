{ config, ... }:
let
  inherit (config.nvix.mkKey) wKeyObj;
in
{
  wKeyList = [
    (wKeyObj [
      "s"
      ""
      "surround"
    ])
  ];
  plugins.which-key.settings.triggers = [
    {
      __unkeyed-1 = "<auto>";
      mode = "nxsot";
    }
    {
      __unkeyed-1 = "s";
      mode = "nv";
    }
  ];
}
