{ lib, ... }:
{
  opts.clipboard = lib.mkForce "";
  clipboard.providers.wl-copy.enable = lib.mkForce false;
}
