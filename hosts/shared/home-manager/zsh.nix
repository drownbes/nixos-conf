{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    initExtra = ''
    '';
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
      theme = "robbyrussell";
    };
  };
}
