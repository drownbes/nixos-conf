# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./cpu.nix
    ./filesystem.nix
    ./gpu.nix
    ./kernel.nix
    ../shared/locale.nix
    ./network.nix
    ../shared/time.nix
    ../shared/fonts.nix

    ../shared/nixpkgs.nix
    ../shared/nix.nix
    ./ollama.nix
    ./searx.nix
    ./keyboard.nix
    ./docker.nix
    ./nordvpn.nix
    ./tailscale.nix
    ./synthing.nix
    ./steam.nix
    ./obs.nix
    ./file-manager.nix
    ./xserver.nix
    ./secrets.nix
    ./ssh.nix
    ./utils.nix
    ./proprietary.nix

    ./beef_market.nix
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.beef_market.nixosModules.beef_market
  ];

  # find a way to define it in home-manager
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drownbes = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "AM";
    extraGroups = ["networkmanager" "wheel" "gamemod" "docker" "nordvpn" "syncthing"];
  };

  environment.systemPackages = with pkgs; [
    gcc
    unstable.nix
    firefox
    chromium
    google-chrome
    flameshot

    unstable.nodePackages_latest.nodejs
    unstable.typescript
    unstable.typescript-language-server

    unstable.anki-bin
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs;
      osConfig = config;
    };
    users = {
      # Import your home-manager configuration
      drownbes = import ./home-manager;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
