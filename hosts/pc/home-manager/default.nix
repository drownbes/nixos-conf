{...}: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./fzf.nix
    ./alacritty.nix
    ./ripgrep.nix
    ./i3wm.nix
    ./rofi.nix
    ./dunst.nix
    ./polybar.nix
    ./picom.nix
    ./autorandr.nix
    ./librewolf.nix
    ./eza.nix
    ./fd.nix
    ./telegram.nix
    ./neovim
    ./copyq.nix
  ];

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
