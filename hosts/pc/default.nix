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
    ./steam.nix
    ./ollama.nix
    ./searx.nix
    ./keyboard.nix
    ./docker.nix
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  age.secrets.openai_token = {
    file = ../../secrets/openai_token.age;
    owner = "drownbes";
    mode = "440";
  };
  environment.variables = {
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai_token.path})";
  };

  # find a way to define it in home-manager
  users.defaultUserShell = pkgs.zsh;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drownbes = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "AM";
    extraGroups = ["networkmanager" "wheel" "gamemod" "docker"];
    packages = with pkgs; [];
  };
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.x86_64-linux.default
    wget
    git
    dolphin
    wget
    pwvucontrol
    clipboard-jh
    nvtopPackages.nvidia
    pamixer
    pulseaudio
    pavucontrol
    vscode
    gcc
    nil
    xclip
  ];

  services.fwupd.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3lock
      ];
    };
  };

  services.displayManager.sddm.enable = true;
  services.hardware.openrgb.enable = true;

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
