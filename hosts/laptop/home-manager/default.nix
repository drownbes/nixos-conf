{...}: {
  imports = [
    ../../shared/home-manager/alacritty.nix
    ../../shared/home-manager/zsh.nix
    ../../shared/home-manager/git.nix
    ../../shared/home-manager/ripgrep.nix
    ../../shared/home-manager/fzf.nix
    ../../shared/home-manager/fd.nix
    ../../shared/home-manager/telegram.nix
    ../../shared/home-manager/eza.nix
    ../../shared/home-manager/neovim
    ./waybar.nix
    ./fuzzel.nix
    ./sway.nix
    ./irssi.nix
  ];

  services.easyeffects.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
