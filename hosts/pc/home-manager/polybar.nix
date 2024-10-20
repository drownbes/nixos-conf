{
  lib,
  config,
  pkgs,
  ...
}:
#TODO: use programs from packages
let
  # taken from: https://github.com/polybar/polybar-scripts
  # polybar-scripts/pipewire-simple/pipewire-simple.sh
  pipewireSimple = pkgs.writeShellScript "pipewire-simple" ''
    getDefaultSink() {
      defaultSink=$(pactl info | awk -F : '/Default Sink:/{print $2}')
      description=$(pactl list sinks | sed -n "/''${defaultSink}/,/Description/s/^\s*Description: \(.*\)/\1/p")
      echo "''${description}"
    }

    getDefaultSource() { defaultSource=$(pactl info | awk -F : '/Default Source:/{print $2}')
      description=$(pactl list sources | sed -n "/''${defaultSource}/,/Description/s/^\s*Description: \(.*\)/\1/p")
      echo "''${description}"
    }

    VOLUME=$(pamixer --get-volume-human)
    SINK=$(getDefaultSink)
    SOURCE=$(getDefaultSource)

    case $1 in
        "--up")
            pamixer --increase 10
            ;;
        "--down")
            pamixer --decrease 10
            ;;
        "--mute")
            pamixer --toggle-mute
            ;;
        *)
            echo "Source: ''${SOURCE} | Sink: ''${VOLUME} ''${SINK}"
    esac
  '';
  #TODO: find where is nvidia smi
  nvidiaSmi = pkgs.writeShellScript "nvidia-smi" ''
    nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print "GPU",""$1"","%"}'
  '';
  colors = {
    background = "#282A2E";
    background-alt = "#373B41";
    foreground = "#C5C8C6";
    primary = "#F0C674";
    secondary = "#8ABEB7";
    alert = "#A54242";
    disabled = "#707880";
  };
in {
  # insure that polybar starts after i3
  systemd.user.services.polybar = {
    Unit.After = ["graphical-session-i3.target"];
    Install.WantedBy = lib.mkForce ["graphical-session-i3.target"];
  };
  services.polybar = {
    enable = true;
    script = "MONITOR=DP-2 ${pkgs.polybar}/bin/polybar top &";
    config = {
      settings = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };

      "bar/top" = {
        width = "100%";
        height = "25pt";
        radius = 6;
        line-size = "3pt";
        border-size = "4pt";
        border-color = "#00000000";
        padding-left = 0;
        padding-right = 1;
        module-margin = 1;

        separator-foreground = colors.disabled;
        separator = "|";

        background = colors.background;
        foreground = colors.foreground;

        enable-ipc = true;
        #wm-restack = "i3";
        #override-redirect = true;

        font-0 = "monospace;2";
        modules-left = "xworkspaces xwindow";
        modules-right = "memory cpu xkeyboard systray date";
      };
      "module/nvidia-smi" = {
        type = "custom/script";
        exec = "${nvidiaSmi}";
        interval = 10;
      };
      "module/pipewire-simple" = {
        type = "custom/script";
        exec = "${pipewireSimple}";
        interval = 1;
        click-right = "exec pavucontrol &";
        click-left = "${pipewireSimple} --mute &";
        scroll-up = "${pipewireSimple} --up &";
        scroll-down = "${pipewireSimple} --down &";
      };

      "module/systray" = {
        type = "internal/tray";
        format-margin = "8pt";
        tray-spacing = "16pt";
      };
      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        label-active = "%name%";
        label-active-background = colors.background-alt;
        label-active-underline = colors.primary;
        label-active-padding = 1;
        label-occupied = "%name%";
        label-occupied-padding = 1;
        label-urgent = "%name%";
        label-urgent-background = colors.alert;
        label-urgent-padding = 1;
        label-empty = "%name%";

        label-empty-foreground = colors.disabled;
        label-empty-padding = 1;
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM ";
        format-prefix-foreground = colors.primary;
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU ";
        format-prefix-foreground = colors.primary;
        label = "%percentage:2%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%H:%M";
        date-alt = "%Y-%m-%d %H:%M:%S";
        label = "%date%";
        label-foreground = colors.primary;
      };
      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";
        label-layout = "%layout%";
        label-layout-foreground = colors.primary;
        label-indicator-padding = 2;
        label-indicator-margin = 1;
        label-indicator-foreground = colors.background;

        label-indicator-background = colors.secondary;
      };
    };
  };
}
