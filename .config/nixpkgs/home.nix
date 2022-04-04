{ config, pkgs, ... }:

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

  fonts.fontconfig.enable = true;

  home.packages = with pkgs;[
     source-code-pro
  ];

  programs.zsh = {
    enable = true;
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "docker-compose" "poetry" ];
      theme = "powerlevel10k/powerlevel10k";
    };
  };

  programs.git = {
    enable = true;
    userName = "SylvanBrocard";
    userEmail = "sylvan.brocard@gmail.com";
  };
}
