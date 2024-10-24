{
  config,
  lib,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";

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
  ];

  services.easyeffects.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";
        height = 20;
        modules-left = [
          "sway/mode"
          "sway/workspaces"
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "temperature"
          "battery"
          "clock"
          "tray"
        ];
        clock = {
          timezone = "Europe/Tallinn";
        };
      };
    };
  };

  programs.fuzzel = {
    enable = true;
  };
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
    extraConfig = ''
      set $top_dell "Dell Inc. DELL U2723QE GN6P5P3"
      set $bottom_aoc "AOC U34G2G1 0x00000123"
      exec way-displays > /tmp/way-displays.$${XDG_VTNR}.$${USER}.log 2>&1
    '';

    config = {
      input = {
        "*" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:caps_toggle";
        };
      };
      terminal = "alacritty";
      menu = "fuzzel -b 000000ff -f SourceCodePro:size=12 -i Arc -w 40 -l 25";
      fonts = {
        names = ["Fira Code"];
        size = 12.0;
      };
      bars = [
        {
          command = "waybar";
        }
      ];
    };
  };

  programs.irssi = {
    enable = true;
    networks = {
      liberachat = {
        nick = "drownbes";
        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          nixos.autoJoin = true;
        };
      };
    };
  };
}
