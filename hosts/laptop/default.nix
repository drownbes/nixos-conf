# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}: let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in {
  imports = [
    # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.home-manager
    ../shared/nixpkgs.nix
    ../shared/nix.nix
    ../shared/fonts.nix
    ../shared/locale.nix
    ../shared/time.nix
    ./filesystem.nix
    ./bluetooth.nix
    ./kernel.nix
    ./audio.nix
    ./framework-hardware.nix
    ./network.nix
  ];
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  security.polkit.enable = true;

  programs.sway.enable = true;
  programs.sway.wrapperFeatures.gtk = true;

  programs.regreet.enable = true;

  services.dbus.enable = true;
  services.fwupd.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drownbes = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  services.touchegg.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dbus-sway-environment
    configure-gtk
    unstable.neovim
    gcc
    wget
    alacritty
    dbus
    wayland
    xdg-utils
    glib
    swaylock
    swayidle
    wl-clipboard
    # mako
    swaynotificationcenter
    wdisplays
    firefox
    git
    fuzzel
    btop
    xdotool
    wmctrl
    unstable.fd
    unstable.nil
    (unstable.shotcut.overrideAttrs (_finalAttrs: previousAttrs: {
      buildInputs = previousAttrs.buildInputs ++ [unstable.kdePackages.qtwayland];
    }))
    way-displays
    unstable.vlc
    libsForQt5.okular
    mpv
    pavucontrol
    p7zip
    ffmpeg_5-full
    intel-gpu-tools
    tor-browser
    networkmanagerapplet
    ngspice

    unstable.nodejs
    unstable.typescript
    unstable.nodePackages.ts-node
    unstable.nodePackages.typescript-language-server
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  xdg.portal.config.common.default = "*";

  environment.variables = {
  };
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  users.extraUsers.drownbes.extraGroups = ["jackaudio" "input"];

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
