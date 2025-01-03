{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
#info https://github.com/arcnmx/nixexprs/blob/07e50ffc9f077359db8704a892f6ca2631d439bf/modules/home/i3.nix
let
  sessionStart = pkgs.writeShellScript "i3-session" ''
    set -eu
    ${osConfig.systemd.package}/bin/systemctl --user set-environment I3SOCK=$(${pkgs.i3}/bin/i3 --get-socketpath)
    ${osConfig.systemd.package}/bin/systemctl --user start graphical-session-i3.target
  '';
  modifier = config.xsession.windowManager.i3.config.modifier;
in {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "gtk";
  };
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
        style = "Bold Semi-Condensed";
        size = 8.0;
      };
      bars = [];
      terminal = "${lib.getExe pkgs.alacritty}";
      menu = "\"${lib.getExe pkgs.rofi} -modi drun, run -show drun\"";
      keybindings = lib.mkOptionDefault {
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+h" = "focus left";
        "${modifier}+l" = "focus right";
      };
    };
  };
  xsession.windowManager.i3.config.startup = [
    {
      command = "${sessionStart}";
      notification = false;
    }
    {
      command = "${osConfig.systemd.package}/bin/systemctl --user restart polybar";
      notification = false;
    }
    #{ command = "xrandr --output HDMI-1 --off --output DP-2 --primary --mode 3440x1440 --pos 0x0 --rotate normal"; notification = false; }
  ];
  # fake target for polybar unit to start
  systemd.user.targets.graphical-session-i3 = {
    Unit = {
      Description = "i3 X session";
      BindsTo = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };
  };
}
