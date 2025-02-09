{
  config,
  pkgs,
  lib,
  outputs,
  ...
}:
let
  cfg = config.modules.home-manager.fish;
in
{
  options.modules.home-manager.fish = {
    defaultShell = lib.mkEnableOption "Set fish as default shell.";
    wezrs.enable = lib.mkEnableOption "Enable support of Zmodem file transefer protocol for wezTerm.";
  };

  config = {
    nixpkgs.overlays = [
      outputs.overlays.self-defined-packages
    ];

    programs.fish = {
      enable = true;
      plugins =
        [
          {
            name = "z";
            src = pkgs.fishPlugins.z.src;
          }
          {
            name = "fzf-fish";
            src = pkgs.fishPlugins.fzf-fish.src;
          }
          {
            name = "tide";
            src = pkgs.fishPlugins.tide.src;
          }

        ]
        ++ lib.optional cfg.wezrs.enable {
          name = "wezrs";
          src = pkgs.self-defined.fishPlugins.wezrs.out;
        };
      interactiveShellInit = ''
        set -U tide_aws_bg_color normal
        set -U tide_aws_color FF9900
        set -U tide_aws_icon \uf270
        set -U tide_character_color 5FD700
        set -U tide_character_color_failure FF0000
        set -U tide_character_icon \u276f
        set -U tide_character_vi_icon_default \u276e
        set -U tide_character_vi_icon_replace \u25b6
        set -U tide_character_vi_icon_visual V
        set -U tide_cmd_duration_bg_color normal
        set -U tide_cmd_duration_color 87875F
        set -U tide_cmd_duration_decimals 0
        set -U tide_cmd_duration_icon \x1d
        set -U tide_cmd_duration_threshold 3000
        set -U tide_context_always_display true
        set -U tide_context_bg_color normal
        set -U tide_context_color_default D7AF87
        set -U tide_context_color_root D7AF00
        set -U tide_context_color_ssh D7AF87
        set -U tide_context_hostname_parts 1
        set -U tide_crystal_bg_color normal
        set -U tide_crystal_color FFFFFF
        set -U tide_crystal_icon \ue62f
        set -U tide_direnv_bg_color normal
        set -U tide_direnv_bg_color_denied normal
        set -U tide_direnv_color D7AF00
        set -U tide_direnv_color_denied FF0000
        set -U tide_direnv_icon \u25bc
        set -U tide_distrobox_bg_color normal
        set -U tide_distrobox_color FF00FF
        set -U tide_distrobox_icon \U000f01a7
        set -U tide_docker_bg_color normal
        set -U tide_docker_color 2496ED
        set -U tide_docker_default_contexts default\x1ecolima
        set -U tide_docker_icon \uf308
        set -U tide_elixir_bg_color normal
        set -U tide_elixir_color 4E2A8E
        set -U tide_elixir_icon \ue62d
        set -U tide_gcloud_bg_color normal
        set -U tide_gcloud_color 4285F4
        set -U tide_gcloud_icon \U000f02ad
        set -U tide_git_bg_color normal
        set -U tide_git_bg_color_unstable normal
        set -U tide_git_bg_color_urgent normal
        set -U tide_git_color_branch 5FD700
        set -U tide_git_color_conflicted FF0000
        set -U tide_git_color_dirty D7AF00
        set -U tide_git_color_operation FF0000
        set -U tide_git_color_staged D7AF00
        set -U tide_git_color_stash 5FD700
        set -U tide_git_color_untracked 00AFFF
        set -U tide_git_color_upstream 5FD700
        set -U tide_git_icon \x1d
        set -U tide_git_truncation_length 24
        set -U tide_git_truncation_strategy \x1d
        set -U tide_go_bg_color normal
        set -U tide_go_color 00ACD7
        set -U tide_go_icon \ue627
        set -U tide_java_bg_color normal
        set -U tide_java_color ED8B00
        set -U tide_java_icon \ue256
        set -U tide_jobs_bg_color normal
        set -U tide_jobs_color 5FAF00
        set -U tide_jobs_icon \uf013
        set -U tide_kubectl_bg_color normal
        set -U tide_kubectl_color 326CE5
        set -U tide_kubectl_icon \U000f10fe
        set -U tide_left_prompt_frame_enabled false
        set -U tide_left_prompt_items context pwd git newline character
        set -U tide_left_prompt_prefix 
        set -U tide_left_prompt_separator_diff_color \x20
        set -U tide_left_prompt_separator_same_color \x20
        set -U tide_left_prompt_suffix \x20
        set -U tide_nix_shell_bg_color normal
        set -U tide_nix_shell_color 7EBAE4
        set -U tide_nix_shell_icon \uf313
        set -U tide_node_bg_color normal
        set -U tide_node_color 44883E
        set -U tide_node_icon \ue24f
        set -U tide_os_bg_color normal
        set -U tide_os_color normal
        set -U tide_os_icon \uf313
        set -U tide_php_bg_color normal
        set -U tide_php_color 617CBE
        set -U tide_php_icon \ue608
        set -U tide_private_mode_bg_color normal
        set -U tide_private_mode_color FFFFFF
        set -U tide_private_mode_icon \U000f05f9
        set -U tide_prompt_add_newline_before true
        set -U tide_prompt_color_frame_and_connection 6C6C6C
        set -U tide_prompt_color_separator_same_color 949494
        set -U tide_prompt_icon_connection \u00b7
        set -U tide_prompt_min_cols 34
        set -U tide_prompt_pad_items false
        set -U tide_prompt_transient_enabled false
        set -U tide_pulumi_bg_color normal
        set -U tide_pulumi_color F7BF2A
        set -U tide_pulumi_icon \uf1b2
        set -U tide_pwd_bg_color normal
        set -U tide_pwd_color_anchors 00AFFF
        set -U tide_pwd_color_dirs 0087AF
        set -U tide_pwd_color_truncated_dirs 8787AF
        set -U tide_pwd_icon \x1d
        set -U tide_pwd_icon_home \x1d
        set -U tide_pwd_icon_unwritable \uf023
        set -U tide_pwd_markers \x2ebzr\x1e\x2ecitc\x1e\x2egit\x1e\x2ehg\x1e\x2enode\x2dversion\x1e\x2epython\x2dversion\x1e\x2eruby\x2dversion\x1e\x2eshorten_folder_marker\x1e\x2esvn\x1e\x2eterraform\x1eCargo\x2etoml\x1ecomposer\x2ejson\x1eCVS\x1ego\x2emod\x1epackage\x2ejson
        set -U tide_python_bg_color normal
        set -U tide_python_color 00AFAF
        set -U tide_python_icon \U000f0320
        set -U tide_right_prompt_frame_enabled false
        set -U tide_right_prompt_items status cmd_duration jobs direnv node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir time
        set -U tide_right_prompt_prefix \x20
        set -U tide_right_prompt_separator_diff_color \x20
        set -U tide_right_prompt_separator_same_color \x20
        set -U tide_right_prompt_suffix \u200b
        set -U tide_ruby_bg_color normal
        set -U tide_ruby_color B31209
        set -U tide_ruby_icon \ue23e
        set -U tide_rustc_bg_color normal
        set -U tide_rustc_color F74C00
        set -U tide_rustc_icon \ue7a8
        set -U tide_shlvl_bg_color normal
        set -U tide_shlvl_color d78700
        set -U tide_shlvl_icon \uf120
        set -U tide_shlvl_threshold 1
        set -U tide_status_bg_color normal
        set -U tide_status_bg_color_failure normal
        set -U tide_status_color 5FAF00
        set -U tide_status_color_failure D70000
        set -U tide_status_icon \u2714
        set -U tide_status_icon_failure \u2718
        set -U tide_terraform_bg_color normal
        set -U tide_terraform_color 844FBA
        set -U tide_terraform_icon \x1d
        set -U tide_time_bg_color normal
        set -U tide_time_color 5F8787
        set -U tide_time_format \x25T
        set -U tide_toolbox_bg_color normal
        set -U tide_toolbox_color 613583
        set -U tide_toolbox_icon \ue24f
        set -U tide_vi_mode_bg_color_default normal
        set -U tide_vi_mode_bg_color_insert normal
        set -U tide_vi_mode_bg_color_replace normal
        set -U tide_vi_mode_bg_color_visual normal
        set -U tide_vi_mode_color_default 949494
        set -U tide_vi_mode_color_insert 87AFAF
        set -U tide_vi_mode_color_replace 87AF87
        set -U tide_vi_mode_color_visual FF8700
        set -U tide_vi_mode_icon_default D
        set -U tide_vi_mode_icon_insert I
        set -U tide_vi_mode_icon_replace R
        set -U tide_vi_mode_icon_visual V
      '';
    };
    programs.fzf = {
      enable = true;
      enableFishIntegration = false;
      defaultOptions = [
        "--cycle"
        "--layout=reverse"
        "--border"
        "--height=90%"
        "--preview-window=wrap"
        "--marker=\"*\""
      ];
    };

    home.packages = lib.optionals cfg.wezrs.enable (
      with pkgs;
      [
        self-defined.trzsz-go
        jq
      ]
    );

    # run fish when start bash interactively
    programs.bash = lib.mkIf cfg.defaultShell {
      enable = true;
      initExtra = ''
        if [[ -z ''${NO_FISH} && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
