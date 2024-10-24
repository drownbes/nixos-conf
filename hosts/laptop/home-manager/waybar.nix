{...}: {
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
}
