{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        pkgs.alacritty-theme.oceanic_next
      ];
      selection = {
        save_to_clipboard = true;
      };
      font = {
        size = 10.0;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
    };
  };
}
