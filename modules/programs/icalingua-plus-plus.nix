{
  pkgs,
  config,
  lib,
  outputs,
  ...
}:
let
  cfg = config.programs.icalingua-plus-plus;
in
{
  options = {
    programs.icalingua-plus-plus = {
      enable = lib.mkEnableOption "Enables Icalingua-plus-plus.";
      bridge = lib.mkEnableOption "Enable Icalingua-plus-plus bridge mode";
      bridgeServer = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Address of bridgeServer";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ outputs.legacyPackages.${pkgs.system}.icalingua-plus-plus ];
  };
}
