{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    # package = pkgs.unstable.alacritty;
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
