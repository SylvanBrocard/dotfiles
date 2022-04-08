{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sylvanbrocard";
  home.homeDirectory = "/home/sylvanbrocard";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set variables for non-NixOS Linux.
  targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs;[
     source-code-pro
     zotero
     micromamba
  ];

  programs.zsh = {
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "docker-compose" "poetry" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    initExtra = ''
      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'mamba init' !!
      export MAMBA_EXE="/nix/store/03gsy3qc996wbrni0lxhrdqm9lfsj6rh-micromamba-0.21.2/bin/micromamba";
      export MAMBA_ROOT_PREFIX="/home/sylvanbrocard/micromamba";
      __mamba_setup="$('/nix/store/03gsy3qc996wbrni0lxhrdqm9lfsj6rh-micromamba-0.21.2/bin/micromamba' shell hook --shell zsh --prefix '/home/sylvanbrocard/micromamba' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__mamba_setup"
      else
          if [ -f "/home/sylvanbrocard/micromamba/etc/profile.d/micromamba.sh" ]; then
              . "/home/sylvanbrocard/micromamba/etc/profile.d/micromamba.sh"
          else
              export  PATH="/home/sylvanbrocard/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
          fi
      fi
      unset __mamba_setup
      # <<< mamba initialize <<<
    '';
  };

  programs.git = {
    enable = true;
    userName = "SylvanBrocard";
    userEmail = "sylvan.brocard@gmail.com";
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      ms-python.python
      eamodio.gitlens
      bbenoist.nix
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      davidanson.vscode-markdownlint
    ];
  };

  programs.emacs = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };
}
