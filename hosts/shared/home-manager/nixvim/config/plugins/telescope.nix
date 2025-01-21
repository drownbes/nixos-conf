{
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    keymaps = {
      "<leader>f" = {
        action = "find_files";
      };
      "<leader>fg" = {
        action = "live_grep";
      };
      "<leader>fb" = {
        action = "buffers";
      };
      "<leader>fh" = {
        action = "help_tags";
      };
    };
  };
}
