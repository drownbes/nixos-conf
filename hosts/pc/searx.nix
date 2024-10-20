{pkgs, ...}: {
  services.searx = {
    enable = true;
    package = pkgs.unstable.searxng;
    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "secret";
      };
      search = {
        formats = [
          "html"
          "json"
          "csv"
        ];
      };
    };
  };
}
