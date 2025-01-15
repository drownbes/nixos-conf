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

    ./beef_market.nix
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.beef_market.nixosModules.beef_market
  ];

  age.secrets.openai_token = {
    file = ../../secrets/openai_token.age;
    owner = "drownbes";
    mode = "440";
  };

  age.secrets.grok_token = {
    file = ../../secrets/grok_token.age;
    owner = "drownbes";
    mode = "440";
  };
  age.secrets.anthropic_token = {
    file = ../../secrets/anthropic_token.age;
    owner = "drownbes";
    mode = "440";
  };
  environment.variables = {
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai_token.path})";
    GROQ_API_KEY = "$(cat ${config.age.secrets.grok_token.path})";
    ANTHROPIC_API_KEY = "$(cat ${config.age.secrets.anthropic_token.path})";
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
    extraGroups = ["networkmanager" "wheel" "gamemod" "docker" "nordvpn" "syncthing"];
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
    xclip
    element-desktop
    unstable.nix
    unstable.obsidian
    unstable.code-cursor
    firefox
    chromium
    google-chrome
    flameshot
  ];

  services.gvfs.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.fwupd.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u14n.psf.gz";
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.4";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    XCURSOR_SIZE = 32;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  };

  services.xserver.displayManager.importedVariables = [
    "GDK_SCALE"
    "GDK_DPI_SCALE"
    "QT_AUTO_SCREEN_SCALE_FACTOR"
  ];

  services.xserver = {
    dpi = 192;
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
