{
  users.users.xiaoyv = {
    hashedPassword = "$y$j9T$J35XhhvIPv6urfZsIcl53/$BLGTHs8uEaFoTbOlxKsgJ3GlYvIdH/PTjMrul2F6jJ8";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELNt/VHFefuWbEeherQ0dMAlBBda/vfNZeYu7HGIKUs xiaoyv_404@outlook.com"
    ];
  };
}
