{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        pkgs.alacritty-theme.oceanic_next
      ];
      selection = {
        save_to_clipboard = true;
      };
      font = {
        size = 10.0;
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
          style = "Italic";
        };
      };
    };
  };
}
