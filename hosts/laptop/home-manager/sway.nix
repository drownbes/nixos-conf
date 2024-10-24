{...}: {
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
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
}
