{pkgs, ...}: {
  imports = [
    ../../shared/home-manager/nixvim
    ../../shared/home-manager/alacritty.nix
    ../../shared/home-manager/fzf.nix
    ../../shared/home-manager/ripgrep.nix
    ../../shared/home-manager/fd.nix
    ../../shared/home-manager/eza.nix
    ../../shared/home-manager/zsh.nix
  ];
  programs.alacritty = {
    settings = {
      font = {
        size = 10.0;
      };
    };
  };
 
  home.stateVersion = "24.11";
}
