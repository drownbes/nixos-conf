{...}: {
  imports = [
    ../../shared/home-manager/git.nix
    ../../shared/home-manager/zsh.nix
    ../../shared/home-manager/fzf.nix
    ../../shared/home-manager/alacritty.nix
    ../../shared/home-manager/ripgrep.nix
    ../../shared/home-manager/fd.nix
    ../../shared/home-manager/telegram.nix
    ../../shared/home-manager/eza.nix
    ../../shared/home-manager/neovim
    #../../shared/home-manager/nixvim
    ./i3wm.nix
    ./rofi.nix
    ./dunst.nix
    ./polybar.nix
    #./picom.nix
    ./autorandr.nix
    ./librewolf.nix
    ./copyq.nix
    ./fabric-ai.nix
    ./tray-target.nix
    ./pasystray.nix
    ./redshift.nix
    ./nix-direnv.nix
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
