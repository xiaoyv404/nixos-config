{
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    outputs.modules.home-manager.users.xiaoyv
  ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
            # A few aliases for exa, a ls replacement
      alias l="exa --sort Name"
      alias ll="exa --sort Name --long"
      alias la="exa --sort Name --long --all"
      alias lr="exa --sort Name --long --recurse"
      alias lra="exa --sort Name --long --recurse --all"
      alias lt="exa --sort Name --long --tree"
      alias lta="exa --sort Name --long --tree --all"

      alias ls="exa --sort Name"
    '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
